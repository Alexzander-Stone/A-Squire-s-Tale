extends KinematicBody2D

signal damaged(damageValue)

##
# Remove this nasty implementation.
##
export(NodePath) var animated_sprite_path
onready var animated_sprite_node = get_node(animated_sprite_path)
onready var previous_position = position

# Movement and direction.
var velocity = Vector2(0,0)
var direction_vector = Vector2(0,0)

func _ready():
	print("Enemy created")

##
# Remove this nasty implementation of animations.
##
func _process(delta):
	#Look right
	if position.x - previous_position.x > 0:
		animated_sprite_node.flip_h = false
	# Look left.
	elif position.x - previous_position.x < 0:
		animated_sprite_node.flip_h = true
	previous_position = position

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