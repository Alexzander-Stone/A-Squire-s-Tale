# Trapping death state.
extends "res://Scripts/State Machine/State.gd"

func enter(args):
	print("Rat killed")
	.enter(args)
	#queue_free()