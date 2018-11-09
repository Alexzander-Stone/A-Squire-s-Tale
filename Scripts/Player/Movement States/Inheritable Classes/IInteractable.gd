# Area2D's can have multiple objects entering/exiting at the same time, so we must check names
# before removing from our current references.
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
		if Input.is_action_just_pressed("interact"):
			# Found interactable object.
			print("Interact found.")
			# If true, begin interacting state.
	.update(delta)

func append_interaction_node(object):
	if colliding_node == null:
		# Keep track of the colliding node.
		colliding_node = object
		print(colliding_node.name)
		# Check to see if player has interacted as soon as the object has entered the collision zone.
		if Input.is_action_pressed("interact"):
			# Found interactable object.
			print("Interact found.")
			# If true, begin interacting state.
			pass

func remove_interaction_node(object):
	# Remove interaction node if it has left the area.
	if colliding_node.name == object.name:
		colliding_node = null