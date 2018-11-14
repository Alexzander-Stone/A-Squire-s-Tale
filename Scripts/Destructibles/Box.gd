extends Node2D


export(int) var health = 3

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")
	
func collisionDetected(colliding_object):
	#in here, check for collision with player hitbox vs. attack.
	#do this for player hitbox
	#physics engine part, need the player to walk into the object, but not through it
	
	#do this for attack
	health -= 1
	if(health == 0):
		#create an instance of the stopwatch
		var scene = load("res://Scenes/Artifacts/Stopwatch.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("Stopwatch")
		scene_instance.position = position
		get_tree().get_root().add_child(scene_instance)
		queue_free()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
