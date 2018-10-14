extends "res://Player/IMortal.gd"

var flinchTimer = 0
var timeToFlinch = 1

func enter():
	flinchTimer = timeToFlinch

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling")
	.update(delta)