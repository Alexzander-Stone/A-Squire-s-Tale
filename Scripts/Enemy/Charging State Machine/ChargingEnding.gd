extends "res://Scripts/State Machine/State.gd"

func enter(args):
	emit_signal("finished", "leaving", [])
