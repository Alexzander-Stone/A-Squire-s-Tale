extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

# Use signal to call this function if casting button has been pressed.
func check_casting():
	#adding a condition for the primary ability, so that we can transition from idle straight to casting
	if Input.is_action_just_pressed("primary_ability") :
		emit_signal("finished", "casting", [0])
	if Input.is_action_just_pressed("secondary_ability") :
		emit_signal("finished", "casting", [1])
	if Input.is_action_just_pressed("ternary_ability") :
		emit_signal("finished", "casting", [2])
	if Input.is_action_just_pressed("super_ability") :
		emit_signal("finished", "casting", [3])
	
	if(Input.is_action_just_pressed("craft")):
		 emit_signal("finished", "crafting", [-1])