extends Area2D

var default_damage = 10
export(bool) var follow_player = false

func _process(delta):
	if !$"AnimationPlayer".is_playing():
		queue_free()

func play_animation(animation_to_play):
	$"AnimationPlayer".play(animation_to_play)

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return default_damage