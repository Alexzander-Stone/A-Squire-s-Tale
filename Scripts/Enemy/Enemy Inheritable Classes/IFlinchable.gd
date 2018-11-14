extends "res://Scripts/Enemy/Enemy Inheritable Classes/IKillable.gd"

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")

# void beginFlinch
# Transitions into the flinch state. Callable from outside object.
# Need to implement cleanup in each state.
func beginFlinch(damage_to_take):
	emit_signal("finished", "Taking Damage", [damage_to_take])

# Collision objects will always be the "weapon" itself.
func collisionDetected(colliding_object):
	# Get the damage value from the colliding object.
	var damage_to_take = colliding_object.calculate_damage()
	beginFlinch(damage_to_take)