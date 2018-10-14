extends "res://Player/Scripts/Movement States/Inheritable Classes/ICastable.gd"

export (int) var VELOCITY = 5

func fillJustPressedArray(array):
	array[0] = int(Input.is_action_just_pressed("ui_left"))
	array[1] = int(Input.is_action_just_pressed("ui_right"))
	array[2] = int(Input.is_action_just_pressed("ui_up"))
	array[3] = int(Input.is_action_just_pressed("ui_down")) 

func fillPressedArray(array):
	array[0] = int(Input.is_action_pressed("ui_left"))
	array[1] = int(Input.is_action_pressed("ui_right"))
	array[2] = int(Input.is_action_pressed("ui_up"))
	array[3] = int(Input.is_action_pressed("ui_down")) 

# void movePlayer
# Updates the object's coordinates depending on the values given by the input array.
# Input array: Index 0 = Left movement, 1 = Right movement, 2 = Up movement, 3 = down movement
func movePlayer(input):
	# Need to account for diagonal movement. Instead of the movement being represented as a square, it is a circle.
	# Then find the coordinates on the circle based on the angle of the 
	# original horizontal and vertical movement.
	var horizontalMove = input[1] - input[0]
	var verticalMove = input[3] - input[2]
	if(horizontalMove != 0 and verticalMove != 0):
		var playerAngle = atan(abs(verticalMove) / abs(horizontalMove))
		owner.velocity.x = cos(playerAngle) * horizontalMove * VELOCITY
		owner.velocity.y = sin(playerAngle) * verticalMove * VELOCITY
	else:
		owner.velocity.x = horizontalMove * VELOCITY 
		owner.velocity.y = verticalMove * VELOCITY 
	owner.update_position()