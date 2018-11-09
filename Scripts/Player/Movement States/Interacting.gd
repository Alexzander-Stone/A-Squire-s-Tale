# State is entered when Player has pressed the interaction button while in the collision box of an interactable object.
extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

func enter(args):
	owner.velocity = Vector2(0,0)
	# Set signal up for communication between interactable objects.

func handle_input(event):
	# Check to see if player wishes to continue the interaction event.
	if event.is_action_pressed("interact") || event.is_action_pressed("interact") || event.is_action_pressed("interact") || event.is_action_pressed("interact"):
		# Emit signal to tell object to go to next interaction step.
		pass

# Signal received to finish interaction.
func end_interaction():
	emit_signal("finished", "walking", [])