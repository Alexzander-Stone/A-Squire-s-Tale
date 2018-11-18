extends "res://Scripts/State Machine/State.gd"

# void toggleDeath
# Send player state to the dying state.
func toggleDeath():
	emit_signal("finished", "dying", [0])