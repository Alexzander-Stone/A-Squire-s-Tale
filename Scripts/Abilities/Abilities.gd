extends Node2D

var current_active_abilities = []

export(int) var primary_length = 1

onready var primary_spawner = preload("res://Scenes/Attack/Attack.tscn")

func spawn_primary(animation_to_play):
	var new = primary_spawner.instance()
	new.get_node("AnimationPlayer").play(animation_to_play)
	add_child(new)
	#print(get_children().size())

func spawn_secondary(animation_to_play):
	pass

func spawn_ternary(animation_to_play):
	pass

func spawn_super(animation_to_play):
	pass