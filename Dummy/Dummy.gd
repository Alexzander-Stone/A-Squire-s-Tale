extends Node2D

signal damaged(damageValue)

export(int) var max_health = 100
onready var current_health = max_health

func _ready():
	print("Dummy created")

func take_damage(damage):
	current_health -= damage
	# Informs UI of change in health.
	emit_signal("damaged", damage)