# Trapping death state.
extends "res://Scripts/State Machine/State.gd"

func enter(args):
	print("Rat killed")
	.enter(args)
	owner.queue_free()