extends "res://Player/IMoving.gd"

var pressedMoves = [0, 0, 0, 0]
func enter():
	VELOCITY = 10

func update(delta):
	fillPressedArray(pressedMoves)
	
	# Check to see if no input has been found, transition to idling if true.
	var moveCounter = 0
	for input in pressedMoves:
		if(input != 0):
			moveCounter += 1
	if(moveCounter == 0):
		emit_signal("finished", "idling")
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)