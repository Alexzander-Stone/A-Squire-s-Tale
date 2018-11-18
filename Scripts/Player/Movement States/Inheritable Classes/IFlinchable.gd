extends "res://Scripts/Player/Movement States/Inheritable Classes/IKillable.gd"

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)

func enter(args):
	collision_node.connect("area_entered", self, "collisionDetected")

func exit():
	collision_node.disconnect("area_entered", self, "collisionDetected")

# void beginFlinch
# Transitions into the flinch state. Callable from outside object.
# Need to implement cleanup in each state.
func beginFlinch(damage_to_take):
	emit_signal("finished", "flinching", [damage_to_take])

# Collision objects will always be the "weapon" itself.
func collisionDetected(colliding_object):
	# Get the damage value from the colliding object.
	var damage_to_take = colliding_object.calculate_damage()
	beginFlinch(damage_to_take)