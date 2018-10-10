extends "res://State Machine/State.gd"

func update(delta):
	# If player wishes to move left, the value will be -1. If they move right, it's 1.
	# And if they press both, it's 0.
	var horizontalMove = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var verticalMove = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if(horizontalMove == 0 and verticalMove == 0):
		emit_signal("finished", "idling")
	
	# Need to account for diagonal movement. Instead of the movement being represented as a square, it is a circle.
	# Then find the coordinates on the circle based on the angle of the 
	# original horizontal and vertical movement.
	if(horizontalMove != 0 and verticalMove != 0):
		var playerAngle = atan(abs(verticalMove) / abs(horizontalMove))
		owner.velocity.x = cos(playerAngle) * horizontalMove * owner.RUN_VELOCITY
		owner.velocity.y = sin(playerAngle) * verticalMove * owner.RUN_VELOCITY
	else:
		owner.velocity.x = horizontalMove * owner.RUN_VELOCITY 
		owner.velocity.y = verticalMove * owner.RUN_VELOCITY 
	
	owner.update_position()