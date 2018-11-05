extends Node2D

var current_active_abilities = []

export(int) var primary_length = 1

onready var primary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var secondary_spawner = preload("res://Scenes/Attack/Utility.tscn")
# Placeholders
onready var ternary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var super_spawner = preload("res://Scenes/Attack/Attack.tscn")

func spawn_primary(animation_to_play):
	var new = primary_spawner.instance()
	new.get_node("AnimationPlayer").play(animation_to_play)
	add_child(new)

func spawn_secondary(animation_to_play):
	var new = secondary_spawner.instance()
	new.get_node("AnimationPlayer").play(animation_to_play)
	add_child(new)

func spawn_ternary(animation_to_play):
	var new = ternary_spawner.instance()
	new.get_node("AnimationPlayer").play(animation_to_play)
	add_child(new)

func spawn_super(animation_to_play):
	var new = super_spawner.instance()
	new.get_node("AnimationPlayer").play(animation_to_play)
	add_child(new)