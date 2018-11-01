# State that exists because of hierarchy for now
extends "res://Scripts/State Machine/State.gd"

func enter(args):
	print("This Shouldn't happen")
	emit_signal("finished", "idling", [0])
