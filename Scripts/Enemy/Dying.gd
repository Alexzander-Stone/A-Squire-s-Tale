# Trapping death state.
extends "res://Scripts/State Machine/State.gd"

var persistent_remains_scene = preload("res://Scenes/Persistent Remains/Persistent Remains.tscn")
var medkit_scene = preload("res://Scenes/Consumables/Medkit.tscn")

func enter(args):
	print("Rat killed")
	.enter(args)
	
	var scene_instance = persistent_remains_scene.instance()
	scene_instance.set_name("Persistent Remains")
	scene_instance.position = owner.position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	
	scene_instance = medkit_scene.instance()
	scene_instance.set_name("Medkit")
	scene_instance.position = owner.position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	
	owner.queue_free()