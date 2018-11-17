extends "res://Scripts/State Machine/State.gd"

export(int) var minimum_charge_length = 10

var player_position
var charge_vector

# args[0] = perceived player position.
# args[1] = backup length, used to determine how far the rat will go when charging.
func enter(args):
	player_position = args[0]
	# Begin running towards direction, based on backup length.
	charge_vector = args[1]
	if charge_vector.length() < 100:
		charge_vector *= 100

func update(delta):
	print("charge vector" + str(charge_vector))
	# Update perceived player's coordinates when player has left the 
	# vision cone or the enemy has reached the coordinates.
	
	##
	#Replace with charging hitbox check and transition to charging.
	##
	if ( 
		owner.position.x <= charge_vector.x + 10 && owner.position.y <= charge_vector.y + 10
		&& owner.position.x >= charge_vector.x - 10 && owner.position.y >= charge_vector.y - 10
		):
		emit_signal("finished", "ending", [])
	else:
		owner.move_and_slide(charge_vector)