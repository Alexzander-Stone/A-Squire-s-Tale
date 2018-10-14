extends "res://Player/IMoving.gd"

var walk_velocity = 5
# Timer for reaching running state.
var runTimer = 0
var timeToRun = .3
# Determine which input to use for run detection
# Left, right. Up, down.
var initialInputs = [0, 0, 0, 0]
var pressedMoves = [0, 0, 0, 0]

func enter():
	VELOCITY = walk_velocity
	
	runTimer = timeToRun
	fillPressedArray(initialInputs)

func exit():
	runTimer = timeToRun

func update(delta):
	# Has player began casting?
	check_casting()
	
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
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)
	
	# Call parent class function.
	.update(delta)

# Boolean hasDoubleTapped
# Returns true if the current just pressed input is the same as the 
# initial input upon entering the walking state.
func hasDoubleTapped():
	var directionChecks = [0, 0, 0, 0]
	fillJustPressedArray(directionChecks)
	
	if(runTimer > 0 and runTimer < timeToRun):
		for i in initialInputs.size():
			if(initialInputs[i] != 0 and initialInputs[i] == directionChecks[i]):
				return true
	return false