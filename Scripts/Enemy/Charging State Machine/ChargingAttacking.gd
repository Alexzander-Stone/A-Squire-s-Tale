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
	if charge_vector.length() < 10:
		charge_vector *= 10