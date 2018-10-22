extends "res://State Machine/State.gd"

# Testing.
func handle_input(event):
	if(event.is_action_pressed(("suicide"))):
		toggleDeath()

# void toggleDeath
# Send player state to the dying state.
func toggleDeath():
	emit_signal("finished", "dying", [0])