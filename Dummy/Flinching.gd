extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

#in here we need to add animation, damage numbers, and HP loss

var flinchTimer = 0
var timeToFlinch = 1

func enter(args):
	
	#use args to take damage to HP and be used in display 
	#for dummy, when you take damage, add it back
	print("Dummy State: hit")
	flinchTimer = timeToFlinch

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [0])
	.update(delta)