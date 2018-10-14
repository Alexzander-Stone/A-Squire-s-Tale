extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

var casting_animation_timer = 0
var timeToAnimate = 2

func enter():
	casting_animation_timer = timeToAnimate
	
	# Will substitute with search for proper ability/animation.
	if(owner.crafting_container.size() > 0):
		for i in owner.crafting_container:
			print("Cast spell " + str(i))

func update(delta):
	if(casting_animation_timer >= 0):
		casting_animation_timer -= delta
	else:
		emit_signal("finished", "idling")
	
	# Call parent class function.
	.update(delta)