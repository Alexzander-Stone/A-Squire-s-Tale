extends "res://Scripts/Player/Movement States/Inheritable Classes/IKillable.gd"

var flinchTimer = 0
var timeToFlinch = 1

export(NodePath) var player_path
export(NodePath) var player_animation_path

onready var player_node = get_node(player_path)
onready var player_animation_node = get_node(player_animation_path)

func enter(args):
	# Change player health. Change damage to be arg passed by enter.
	player_node.take_damage(90)
	# Enter dying state when player's health is equal to or below zero.
	if player_node.current_health <= 0:
		emit_signal("finished", "dying", [])
	
	player_animation_node.play("Flinching")
	flinchTimer = player_animation_node.current_animation_length / player_animation_node.playback_speed

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [])
	.update(delta)
