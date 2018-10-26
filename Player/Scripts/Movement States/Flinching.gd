extends "res://Player/Scripts/Movement States/Inheritable Classes/IKillable.gd"

signal damaged(damageValue)

var flinchTimer = 0
var timeToFlinch = 1

<<<<<<< HEAD
func enter():
	# Inform UI of change in health.
	emit_signal("damaged", 10)
=======
func enter(args):
>>>>>>> Player-Hitbox-and-Attack
	flinchTimer = timeToFlinch

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [0])
	.update(delta)