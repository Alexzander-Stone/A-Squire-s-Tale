extends "res://State Machine/State.gd"

# void beginFlinch
# Transitions into the flinch state. Callable from outside object.
# Need to implement cleanup in each state.
func beginFlinch():
	emit_signal("finished", "flinching")

func update(delta):
	print("hello")
	# Testing flinch.
	if(Input.is_action_just_pressed("ui_page_up")):
		beginFlinch()