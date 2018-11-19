extends Area2D

export(String) var statusEffect = "Warcry"

var damageMod = 0.0
var default_damage = 0
export(bool) var follow_player = true

signal giveStatus

func _ready():
	#for now, warcry works to give all players a movespeed and damage boost
	for p in get_tree().get_nodes_in_group("player"):
		self.connect("giveStatus", p, "addStatusEffect")
	
	

func _process(delta):
	if !$"AnimationPlayer".is_playing():
		print("Warcry complete")
		emit_signal("giveStatus", statusEffect)
		queue_free()

func play_animation(animation_to_play):
	$"AnimationPlayer".play(animation_to_play)

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return default_damage*damageMod