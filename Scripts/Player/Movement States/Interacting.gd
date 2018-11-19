# State is entered when Player has pressed the interaction button while in the collision box of an interactable object.
extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

export(NodePath) var interaction_collision_path
onready var interaction_collision_node = get_node(interaction_collision_path)

var interactable_node = null

# Args[0] = Node that is initialized to interact with.
func enter(args):
	.enter(args)
	owner.velocity = Vector2(0,0)
	# Set signal up for communication between interactable objects.
	interactable_node = args[0]
	# Begin the interaction.

	var theres_more = interactable_node.inititate_interaction()
	if not theres_more:
		end_interaction()


# When leaving the interacting state, we want to set the colliding_node to null
# so we don't get stuck in a neverending interacting loop.
func exit():
	.exit()
	interaction_collision_node.colliding_node = null


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
	emit_signal("finished", "idling", [])