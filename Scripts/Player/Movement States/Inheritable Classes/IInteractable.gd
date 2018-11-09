# Area2D's can have multiple objects entering/exiting at the same time, so we must check names
# before removing from our current references.

# May need to add a list of object's that have entered/left, that way they player can
# immediately interact with the next node without letting it re-enter the player's
# hitbox.
extends "res://Scripts/Player/Movement States/Inheritable Classes/ICastable.gd"

var colliding_node = null

export(NodePath) var interaction_collision_path
var interaction_collision_node

func _ready():
	interaction_collision_node = get_node(interaction_collision_path)
	interaction_collision_node.connect("area_entered", self, "append_interaction_node")
	interaction_collision_node.connect("area_exited", self, "remove_interaction_node")

func update(delta):
	# Collision object is still within current scene's collider.
	if colliding_node != null:
		# Check to see if Player wants to interact with the node.
		if Input.is_action_just_pressed("interact"):
			emit_signal("finished", "interacting", [colliding_node.get_owner()])
	.update(delta)

func append_interaction_node(object):
	if colliding_node == null:
		# Keep track of the colliding node.
		colliding_node = object
		# Check to see if Player wants to interact with the node.
		if Input.is_action_just_pressed("interact"):
			emit_signal("finished", "interacting", [colliding_node.get_owner()])

func remove_interaction_node(object):
	# Remove interaction node if it has left the area.
	if colliding_node.name == object.name:
		colliding_node = null