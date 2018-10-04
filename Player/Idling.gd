extends "res://Player/Scripts/Select.gd"

func handle_input(event):
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left") || event.is_action_pressed("ui_up") || event.is_action_pressed("ui_down"):
		emit_signal("finished", "walking")
	return .handle_input(event)