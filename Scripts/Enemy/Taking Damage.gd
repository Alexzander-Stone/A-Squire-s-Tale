extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

var flinchTimer = 0
var timeToFlinch = 1

export(NodePath) var enemy_path
export(NodePath) var enemy_animation_path

onready var enemy_node = get_node(enemy_path)
onready var enemy_animation_node = get_node(enemy_animation_path)

func enter(args):
	.enter(args)
	enemy_node.take_damage(args[0])
	
	if $"../../Stats".currentHealth <= 0:
		emit_signal("finished", "dying", [])
	
	enemy_animation_node.play("Flinching")
	flinchTimer = enemy_animation_node.current_animation_length / enemy_animation_node.playback_speed

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [])
	.update(delta)