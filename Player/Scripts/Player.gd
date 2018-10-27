extends Node2D

signal damaged(damageValue)

# Movement.
var velocity = Vector2(0,0)
var MOVE_VELOCITY = 0
# Crafting.
var crafting_container = []
# Health points.
var current_health = 100

func _ready():
	print("PC created")

func update_position():
	position += velocity

func add_to_crafting(integer):
	crafting_container.append(integer)

func take_damage(damage):
	current_health -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)