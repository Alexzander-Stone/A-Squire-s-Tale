extends Node

signal medkit_acquired

export(NodePath) var collision_path 
onready var collision_node = get_node(collision_path)

export(int) var health_restore = 50

func _ready():
	collision_node.connect("area_entered", self, "collisionDetected")
	
	#connecting to the player node, allows for multiple players
	#player is currently added to the group in the PlayerStats node, not the base node
	var player_group = get_tree().get_nodes_in_group("player")
	for p in player_group:
		self.connect("medkit_acquired", p, "medkit_collected")
	
func collisionDetected(colliding_object):
	emit_signal("medkit_acquired", health_restore)
	#queue for deletion at the end of the frame
	queue_free()