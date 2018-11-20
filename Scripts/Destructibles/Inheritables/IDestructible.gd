extends KinematicBody2D

export(NodePath) var hitbox_path 
onready var hitbox_node = get_node(hitbox_path)

export(int) var health = 3
var velocity = Vector2(0,0)

func _ready():
	hitbox_node.connect("area_entered", self, "collision_detected")

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

##
# This doesn't do anything?
##
#func take_damage(damage):
#	print("helelele")
#	health -= damage
#	if(health <= 0):
#		destroy()

func collision_detected(colliding_object):
	#reference colliding object
	health -= 1
	if(health <= 0):
		destroy()

func destroy():
	queue_free()