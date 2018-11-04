extends Area2D

var default_damage = 10

func _ready():
	$AnimationPlayer.play("Idle")

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return default_damage