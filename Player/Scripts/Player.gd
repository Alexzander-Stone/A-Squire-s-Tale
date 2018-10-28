extends Node2D

signal damaged(damageValue)

# Movement and direction.
var velocity = Vector2(0,0)
var direction
var MOVE_VELOCITY = 0
# Crafting.
var crafting_container = []
# Health points.
var current_health = 100

func _ready():
	print("PC created")
	get_node("KinematicBody2D").position = position

func update_position():
	#position += velocity
	update_direction()
	if get_node("KinematicBody2D").move_and_collide(velocity):
		print("collide")
	position = get_node("KinematicBody2D").position

func update_direction():
	direction = velocity.normalized()

func add_to_crafting(integer):
	crafting_container.append(integer)

func take_damage(damage):
	current_health -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)