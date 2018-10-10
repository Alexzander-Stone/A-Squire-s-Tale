extends Node2D

var velocity = Vector2(0,0)
var WALK_VELOCITY = 5
var RUN_VELOCITY = 10

func _ready():
	print("created")

func _process(delta):
	return

func update_position():
	position += velocity