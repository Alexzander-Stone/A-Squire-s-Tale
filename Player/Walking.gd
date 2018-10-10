extends "res://State Machine/State.gd"

# Timer for reaching running state.
var runTimer = 0
var timeToRun = .3
var horizontalRun = 0
var verticalRun = 0

func enter():
	runTimer = timeToRun

func exit():
	runTimer = timeToRun

func update(delta):
	var horizontalRun = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	var verticalRun = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	print("timer" + str(runTimer))
	# Timer to check during first few frames of walking.
	if(runTimer > 0 and runTimer < timeToRun and (horizontalRun != 0 or verticalRun != 0)):
		print("hello")
		emit_signal("finished", "running")
	elif(runTimer > 0):
		runTimer -= 1 * delta
	
	# If player wishes to move left, the value will be -1. If they move right, it's 1.
	# And if they press both, it's 0.
	var horizontalMove = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var verticalMove = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if(runTimer <= 0 and horizontalMove == 0 and verticalMove == 0):
		emit_signal("finished", "idling")
	
	# Need to account for diagonal movement. Instead of the movement being represented as a square, it is a circle.
	# Then find the coordinates on the circle based on the angle of the 
	# original horizontal and vertical movement.
	if(horizontalMove != 0 and verticalMove != 0):
		var playerAngle = atan(abs(verticalMove) / abs(horizontalMove))
		owner.velocity.x = cos(playerAngle) * horizontalMove * owner.WALK_VELOCITY
		owner.velocity.y = sin(playerAngle) * verticalMove * owner.WALK_VELOCITY
	else:
		owner.velocity.x = horizontalMove * owner.WALK_VELOCITY 
		owner.velocity.y = verticalMove * owner.WALK_VELOCITY 
	
	owner.update_position()