extends Node2D

var velocity = Vector2(0,0)
var MOVE_VELOCITY = 0

var crafting_container = []

func _ready():
	print("PC created")

func update_position():
	position += velocity

func add_to_crafting(integer):
	crafting_container.append(integer)