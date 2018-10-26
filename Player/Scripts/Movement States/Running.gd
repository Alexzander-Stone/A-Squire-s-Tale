extends "res://Player/Scripts/Movement States/Inheritable Classes/IMoving.gd"

var pressedMoves = [0, 0, 0, 0]

func update(delta):
	# Has player began casting?
	check_casting()
	
	fillPressedArray(pressedMoves)
	# Check to see if no input has been found, transition to idling if true.
	var moveCounter = 0
	for input in pressedMoves:
		if(input != 0):
			moveCounter += 1
	if(moveCounter == 0):
		emit_signal("finished", "idling", [0])
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)
	
	# Call parent class function.
	.update(delta)