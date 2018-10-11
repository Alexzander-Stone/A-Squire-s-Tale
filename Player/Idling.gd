extends "res://Player/ICastable.gd"

func enter():
	owner.velocity = Vector2(0,0)

func handle_input(event):
	# Check to see if casting has been initiated.
	check_casting()
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left") || event.is_action_pressed("ui_up") || event.is_action_pressed("ui_down"):
		emit_signal("finished", "walking")
	return .handle_input(event)