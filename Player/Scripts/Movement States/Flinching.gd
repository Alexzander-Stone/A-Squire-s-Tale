extends "res://Player/Scripts/Movement States/Inheritable Classes/IKillable.gd"

var flinchTimer = 0
var timeToFlinch = 1

func enter(args):
	flinchTimer = timeToFlinch

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [0])
	.update(delta)