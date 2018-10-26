extends "res://Player/Scripts/Movement States/Inheritable Classes/ICastable.gd"

func enter(args):
	owner.velocity = Vector2(0,0)
	# When transitioning to the idling state, check for any movement
	# inputs that are being pressed immediately. Removes the odd transtion of: 
	# Casting -> Idling -> Walking and now has Casting -> Walking.
	if Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		emit_signal("finished", "walking", [0])


func handle_input(event):
	# Check to see if casting has been initiated.
	check_casting()
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left") || event.is_action_pressed("ui_up") || event.is_action_pressed("ui_down"):
		emit_signal("finished", "walking", [0])
	
	return .handle_input(event)