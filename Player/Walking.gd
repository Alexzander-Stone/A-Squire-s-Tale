extends "res://Player/Scripts/Select.gd"

# Will need to be a variable that all can reach, probably
# placed in parent object.
var velocity = Vector2()

func update(delta):
	# If player wishes to move left, the value will be -1. If they move right, it's 1.
	# And if they press both, it's 0.
	var horizontalMove = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	var verticalMove = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if(horizontalMove == 0 and verticalMove == 0):
		emit_signal("finished", "idling")
	
	velocity.x += horizontalMove * delta
	velocity.y += verticalMove * delta
	
	owner.position = owner.position + velocity