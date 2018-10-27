extends "res://Player/Scripts/Movement States/Inheritable Classes/IKillable.gd"

var flinchTimer = 0
var timeToFlinch = 1

var player_node

func _ready():
	player_node = $"../.."

func enter():
	# Change player health.
	player_node.take_damage(90)
	# Enter dying state when player's health is equal to or below zero.
	if player_node.current_health <= 0:
		emit_signal("finished", "dying")
func enter(args):
	flinchTimer = timeToFlinch

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [0])
	.update(delta)
