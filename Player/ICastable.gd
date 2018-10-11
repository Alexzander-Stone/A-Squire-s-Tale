extends "res://State Machine/State.gd"

# Use signal to call this function if casting button has been pressed.
func check_casting():
	if(Input.is_action_just_pressed("ui_cast")):
		 emit_signal("finished", "casting")