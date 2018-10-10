extends "res://State Machine/State.gd"

# Timer for reaching running state.
var runTimer = 0
var timeToRun = .3
# Determine which input to use for run detection.
var runInputs = [0, 0, 0, 0]

func enter():
	runTimer = timeToRun
	updateMovementArray(runInputs)

func exit():
	runTimer = timeToRun

func update(delta):
	# Timer to check during first few frames of walking.
	if hasDoubleTapped():
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

func hasDoubleTapped():
	var directionChecks = [0, 0, 0, 0]
	updateMovementArray(directionChecks)
	
	if(runTimer > 0 and runTimer < timeToRun):
		for i in runInputs.size():
			if(runInputs[i] != 0 and runInputs[i] == directionChecks[i]):
				return true
	return false

func updateMovementArray(array):
	array[0] = int(Input.is_action_just_pressed("ui_left"))
	array[1] = int(Input.is_action_just_pressed("ui_right"))
	array[2] = int(Input.is_action_just_pressed("ui_up"))
	array[3] = int(Input.is_action_just_pressed("ui_down")) 