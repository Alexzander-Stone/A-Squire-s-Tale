extends KinematicBody2D


export(int) var health = 3
var velocity = Vector2(0,0)

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")
	
func _physics_process(delta):
	if(test_move(transform, Vector2(-1, 0))):
		velocity.x = 50
	elif(test_move(transform, Vector2(1, 0))):
		velocity.x = -50
	elif(test_move(transform, Vector2(0, -1))):
		velocity.y = 50
	elif(test_move(transform, Vector2(0, 1))):
		velocity.y = -50
	else:
		velocity = velocity*.5
	
	move_and_slide(velocity)
	
func take_damage(damage):
	health -= 1
	if(health == 0):
		destroy()

func collisionDetected(colliding_object):
	#reference colliding object
	health -= 1
	if(health == 0):
		destroy()
func destroy():
	#create an instance of the stopwatch
	var scene = load("res://Scenes/Artifacts/Stopwatch.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Stopwatch")
	scene_instance.position = global_position
	get_node("/root/World/Environment/Level").add_child(scene_instance)
	queue_free()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
