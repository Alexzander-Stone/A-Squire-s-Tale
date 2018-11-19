# Trapping death state.
extends "res://Scripts/State Machine/State.gd"

func enter(args):
	print("Rat killed")
	.enter(args)
	var scene = load("res://Scenes/Persistent Remains/Persistent Remains.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Persistent Remains")
	scene_instance.position = owner.position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	
	scene = load("res://Scenes/Consumables/Medkit.tscn")
	scene_instance = scene.instance()
	scene_instance.set_name("Medkit")
	scene_instance.position = owner.position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	owner.queue_free()