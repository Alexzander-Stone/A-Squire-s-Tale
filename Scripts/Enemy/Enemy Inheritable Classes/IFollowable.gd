# Inheritable script that will transition to following if player
# is found within the enemy's vision.

# Must prevent vision_node signals from sending non-followable states into
# Following. To do this, attach and detach the collision signal in the enter and exit
# methods, respectively.
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

export(NodePath) var vision_path
var vision_node

func _ready(): 
	vision_node = get_node(vision_path)

func enter(args):
	vision_node.connect("area_entered", self, "check_if_player")
	.enter(args)

func exit():
	vision_node.disconnect("area_entered", self, "check_if_player")
	.exit()

func check_if_player(collided_object):
	# If the collided node is the player, begin following them.
	##
	#Replace name check with group check.
	##
	
	# Verify that the current state is active before moving to the following state.
	if collided_object.owner.name == "Player":
		emit_signal("finished", "following", [collided_object.owner])