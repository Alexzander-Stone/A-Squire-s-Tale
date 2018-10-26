extends Node2D

var velocity = Vector2(0,0)
var MOVE_VELOCITY = 0

var crafting_container = []

func _ready():
	print("PC created")
	get_node("KinematicBody2D").position = position

func update_position():
	#position += velocity
	if get_node("KinematicBody2D").move_and_collide(velocity):
		print("collide")
	position = get_node("KinematicBody2D").position

func add_to_crafting(integer):
	crafting_container.append(integer)