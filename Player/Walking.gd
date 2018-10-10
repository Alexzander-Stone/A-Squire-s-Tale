extends "res://Player/IMoving.gd"

# Timer for reaching running state.
var runTimer = 0
var timeToRun = .3
# Determine which input to use for run detection
# Left, right. Up, down.
var runInputs = [0, 0, 0, 0]
var pressedMoves = [0, 0, 0, 0]

func enter():
	runTimer = timeToRun
	fillPressedArray(runInputs)

func exit():
	runTimer = timeToRun

func update(delta):
	# Determine which movement inputs have been used this update.
	fillPressedArray(pressedMoves)
	
	# Timer to check during first few frames of walking.
	if hasDoubleTapped():
		emit_signal("finished", "running")
	elif(runTimer > 0):
		runTimer -= 1 * delta
	
	# Check to see if no input has been found, transition to idling if true.
	if(runTimer <= 0):
		var moveCounter = 0
		for input in pressedMoves:
			if(input != 0):
				moveCounter += 1
		if(moveCounter == 0):
			emit_signal("finished", "idling")
	
	# Need to account for diagonal movement. Instead of the movement being represented as a square, it is a circle.
	# Then find the coordinates on the circle based on the angle of the 
	# original horizontal and vertical movement.
	var horizontalMove = pressedMoves[1] - pressedMoves[0]
	var verticalMove = pressedMoves[3] - pressedMoves[2]
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
	fillJustPressedArray(directionChecks)
	
	if(runTimer > 0 and runTimer < timeToRun):
		for i in runInputs.size():
			if(runInputs[i] != 0 and runInputs[i] == directionChecks[i]):
				return true
	return false