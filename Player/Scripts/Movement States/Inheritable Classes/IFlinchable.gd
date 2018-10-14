extends "res://Player/Scripts/Movement States/Inheritable Classes/IMortal.gd"

func update(delta):
	# Testing flinch.
	if(Input.is_action_just_pressed("ui_page_up")):
		beginFlinch()
	.update(delta)

# void beginFlinch
# Transitions into the flinch state. Callable from outside object.
# Need to implement cleanup in each state.
func beginFlinch():
	emit_signal("finished", "flinching")