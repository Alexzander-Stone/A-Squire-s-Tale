extends "res://Player/IFlinchable.gd"

# Use signal to call this function if casting button has been pressed.
func check_casting():
	if(Input.is_action_just_pressed("craft")):
		 emit_signal("finished", "crafting")