# State that exists because of hierarchy for now
extends "res://State Machine/State.gd"

func enter():
	print("Dead Dead Dummy")
	emit_signal("finished", "idling")
