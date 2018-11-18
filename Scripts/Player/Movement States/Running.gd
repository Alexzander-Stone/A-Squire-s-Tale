extends "res://Scripts/Player/Movement States/Inheritable Classes/IMoving.gd"

# Input moves.
var pressedMoves = [0, 0, 0, 0]

func enter(args):
	VELOCITY = $"../../Stats".mRunSpeed
	.enter(args)

func update(delta):
	# Has player began casting?
	check_casting()
	# Fill array with current movement input.
	fillPressedArray(pressedMoves)
	# Check to see if no input has been found, transition to idling if true.
	var moveCounter = 0
	for input in pressedMoves:
		if(input != 0):
			moveCounter += 1
	if(moveCounter == 0):
		emit_signal("finished", "idling", [])
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)
	
	# Call parent class function.
	.update(delta)
func exit():
	.exit()