extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal artifact_acquired
export(String) var artifactName = "NULL"

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")
	
	##
	#connecting to the player node, allows for multiple players
	#player is currently added to the group in the PlayerStats node, not the base node
	##
	var player_group = get_tree().get_nodes_in_group("player")
	for p in player_group:
		self.connect("artifact_acquired", p, "addArtifact")
	
func collisionDetected(colliding_object):
	emit_signal("artifact_acquired", [artifactName])
	#queue for deletion at the end of the frame
	queue_free()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
