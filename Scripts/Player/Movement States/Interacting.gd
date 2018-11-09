# State is entered when Player has pressed the interaction button while in the collision box of an interactable object.
extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

var interactable_node = null

# Args[0] = Node that is initialized to interact with.
func enter(args):
	owner.velocity = Vector2(0,0)
	# Set signal up for communication between interactable objects.
	interactable_node = args[0]
	# Begin the interaction.
	interactable_node.inititate_interaction()
	.enter(args)

func handle_input(event):
	# Check to see if player wishes to continue the interaction event.
	if Input.is_action_just_pressed("interact"):
		# Emit signal to tell object to go to next interaction step.
		# Player will be notified of when the interaction has ended from the interactable object.
		# Given active state boolean.
		var is_finished = !interactable_node.next_interaction()
		if is_finished:
			end_interaction() 

# Signal received to finish interaction.
func end_interaction():
	emit_signal("finished", "idling", ["remove_interaction_keybounce"])