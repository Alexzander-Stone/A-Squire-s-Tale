extends KinematicBody2D

signal damaged(damageValue)
signal healed(healValue)

# Movement and direction.
var velocity = Vector2(0,0)
var direction_vector = Vector2(0,0)

# Crafting.
var crafting_container = []
# Health points.
# export(int) var max_health = 100
# onready var current_health = max_health

func _ready():
	##
	#player is added to player group
	##
	add_to_group("player")
	print("PC created")

func update_position():
	#position += velocity
	#var collision = move_and_collide(velocity)
	
	#using move_and_slide would allow for pushing blocks around
	#50 is a placeholder value. It achieves roughly the same movement as with move_and_collide
	move_and_slide(velocity*50)

func update_direction_vector():
	direction_vector = velocity.normalized()

func add_to_crafting(integer):
	crafting_container.append(integer)

# Used during initial step of flinching state.
func take_damage(damage):
	$"Stats".currentHealth -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)

#routing signals to stats script
func addArtifact(artifact):
	$"Stats".addArtifact(artifact)
	
func addStatusEffect(status):
	$"Stats".addStatus(status)

func medkitCollected(health):
	$"Stats".heal(health[0])
	emit_signal("healed", health[0])