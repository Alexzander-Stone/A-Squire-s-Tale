extends "res://Scripts/Player/Movement States/Inheritable Classes/ICastable.gd"

func handle_input(event):
	# Check to see if player is colliding with an interactable object after interact is pressed.
	if event.is_action_pressed("interact"):
		# Check collision.
		# If true, begin interacting state.
		pass
	.handle_input(event)