extends "res://Scripts/Player/Movement States/Inheritable Classes/ICastable.gd"
#in here, have code for "if collided with, go to flinching

var dummy_collision_node

func _ready():
	dummy_collision_node = $"../../Full Sprite/AnimatedSprite/Area2D"
	dummy_collision_node.connect("area_entered", self, "collisionDetected")

func collisionDetected(colliding_object):
	beginFlinch()