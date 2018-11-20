extends "res://Scripts/Destructibles/Inheritables/IDestructible.gd"

func destroy():
	#this will just destroy the pot on player or attack collision
	var scene = load("res://Scenes/Consumables/Medkit.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Medkit")
	scene_instance.position = global_position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	.destroy()