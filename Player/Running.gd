extends "res://Player/IMoving.gd"

var currentInputs = [0, 0, 0, 0]

func update(delta):
	fillPressedArray(currentInputs)
	
	# Check to see if no input has been found, transition to idling if true.
	var moveCounter = 0
	for input in currentInputs:
		if(input != 0):
			moveCounter += 1
	if(moveCounter == 0):
		emit_signal("finished", "idling")
	
	# Need to account for diagonal movement. Instead of the movement being represented as a square, it is a circle.
	# Then find the coordinates on the circle based on the angle of the 
	# original horizontal and vertical movement.
	var horizontalMove = currentInputs[1] - currentInputs[0]
	var verticalMove = currentInputs[3] - currentInputs[2]
	if(horizontalMove != 0 and verticalMove != 0):
		var playerAngle = atan(abs(verticalMove) / abs(horizontalMove))
		owner.velocity.x = cos(playerAngle) * horizontalMove * owner.RUN_VELOCITY
		owner.velocity.y = sin(playerAngle) * verticalMove * owner.RUN_VELOCITY
	else:
		owner.velocity.x = horizontalMove * owner.RUN_VELOCITY 
		owner.velocity.y = verticalMove * owner.RUN_VELOCITY 
	
	owner.update_position()