extends "res://Player/IMoving.gd"

var cast_velocity = 2
var pressedMoves = [0, 0, 0, 0]
var castInput = 0

func enter():
	VELOCITY = cast_velocity

func update(delta):
	# Check casting actions.
	castInput = int(Input.is_action_pressed("ui_cast"))
	if(castInput == 1):
		print("schmee")
	else:
		print("SCHMAA")
		emit_signal("finished", "idling")
	
	# Determine which movement inputs have been used this update.
	fillPressedArray(pressedMoves)
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)