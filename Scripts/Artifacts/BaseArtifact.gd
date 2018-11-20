extends Node

signal artifact_acquired

export(String) var artifactName = "NULL"

export(NodePath) var collision_path 
onready var collision_node = get_node(collision_path)

func _ready():
	collision_node.connect("area_entered", self, "collisionDetected")
	
	# Multiple player's means that all of them should be able to pick up on the trinket.
	# We use the Player group to attach the collision signals, since all playable
	# characters are found there.
	var player_group = get_tree().get_nodes_in_group("player")
	for p in player_group:
		self.connect("artifact_acquired", p, "addArtifact")
	
func collisionDetected(colliding_object):
	emit_signal("artifact_acquired", [artifactName])
	queue_free()