extends KinematicBody2D

signal damaged(damageValue)

# Movement and direction.
var velocity = Vector2(0,0)
var direction_vector = Vector2(0,0)

# Crafting.
var crafting_container = []
# Health points.
var current_health = 100

func _ready():
	print("PC created")

func update_position():
	#position += velocity
	move_and_collide(velocity)

func update_direction_vector():
	direction_vector = velocity.normalized()
	print(direction_vector)

func add_to_crafting(integer):
	crafting_container.append(integer)

func take_damage(damage):
	current_health -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)