extends Area2D

export (int) var attack_damage = 10

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return attack_damage