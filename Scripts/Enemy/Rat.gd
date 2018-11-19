extends KinematicBody2D

signal damaged(damageValue)

# Movement and direction.
var velocity = Vector2(0,0)
var direction_vector = Vector2(0,0)

func _ready():
	print("Enemy created")

func update_position():
	#position += velocity
	move_and_collide(velocity)

func update_direction_vector():
	direction_vector = velocity.normalized()

# Used during initial step of flinching state.
func take_damage(damage):
	$"Stats".currentHealth -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)