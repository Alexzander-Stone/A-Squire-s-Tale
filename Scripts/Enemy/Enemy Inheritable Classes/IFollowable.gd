# Inheritable script that will transition to following if player
# is found within the enemy's vision.
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

export(NodePath) var vision_path
var vision_node

func _ready(): 
	vision_node = get_node(vision_path)
	vision_node.connect("area_entered", self, "check_if_player")

func check_if_player(collided_object):
	# If the collided node is the player, begin following them.
	##
	#Replace name check with group check.
	##
	if collided_object.owner.name == "Player":
		print("found player")
		#emit_signal("finished", "following", [collided_object.owner.position])