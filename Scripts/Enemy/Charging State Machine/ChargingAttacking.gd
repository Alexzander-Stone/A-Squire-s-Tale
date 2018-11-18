extends "res://Scripts/State Machine/State.gd"

export(NodePath) var charging_hitbox_path
onready var charging_hitbox_node = get_node(charging_hitbox_path)

export(int) var minimum_charge_length = 10

var player_position
var charge_vector
var leftover_charge_vector

var previous_position

# args[0] = perceived player position.
# args[1] = backup position, used to determine how far the rat will go when charging.
func enter(args):
	player_position = args[0]
	# Begin running towards direction, based on backup length.
	charge_vector = (player_position - owner.position) * 2
	if charge_vector.length() < 50:
		charge_vector *= 20
	leftover_charge_vector = charge_vector.abs()
	
	# Enable the hitbox.
	charging_hitbox_node.monitorable = true
	charging_hitbox_node.monitoring = true
	
	# Set up signal so enemy can end charge if it hits a player.
	charging_hitbox_node.connect("area_entered", self, "end_charge")
	
	# Move player and check how much it has moved.
	previous_position = owner.position
	owner.move_and_slide(charge_vector)
	leftover_charge_vector -= (owner.position - previous_position).abs()

func exit():
	# Disable the hitbox. Collision boxes can't be disabled on the frame that they are called.
	# Defer to later time.
	charging_hitbox_node.call_deferred("set_monitoring", false)
	charging_hitbox_node.call_deferred("set_monitorable", false)
	
	charging_hitbox_node.disconnect("area_entered", self, "end_charge")

func update(delta):
	# Update perceived player's coordinates when player has left the 
	# vision cone or the enemy has reached the coordinates.
	
	##
	#Replace with charging hitbox check and transition to charging.
	##
	if ( 
		leftover_charge_vector.x <= 0 && leftover_charge_vector.y <= 0
		):
		emit_signal("finished", "ending", [])
	else:
		# Move player and check how much it has moved.
		previous_position = owner.position
		owner.move_and_slide(charge_vector)
		leftover_charge_vector -= (owner.position - previous_position).abs()

func end_charge(collided_object):
	##
	#Change to player group. Can also include walls.
	##
	#if collided_object.name == "Player":
	emit_signal("finished", "ending", [charge_vector])