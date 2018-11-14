extends Node2D


export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")
	
func collisionDetected(colliding_object):
	#this will just destroy the pot on player or attack collision
	var scene = load("res://Scenes/Consumables/Medkit.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Medkit")
	scene_instance.position = position
	get_tree().get_root().add_child(scene_instance)
	
	queue_free()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
