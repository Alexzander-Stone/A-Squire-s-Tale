extends "res://Scripts/Destructibles/Inheritables/IDestructible.gd"

func destroy():
	#create an instance of the stopwatch
	var scene = load("res://Scenes/Artifacts/Stopwatch.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Stopwatch")
	scene_instance.position = global_position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	.destroy()