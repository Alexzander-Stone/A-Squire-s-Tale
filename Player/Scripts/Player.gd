extends Node2D

var velocity = Vector2(0,0)

func _ready():
	print("created")

func _process(delta):
	return

func update_position():
	position += velocity