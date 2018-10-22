# State that exists because of hierarchy for now
extends "res://State Machine/State.gd"

func enter():
	print("Dummy State: dead")
	emit_signal("finished", "idling")
