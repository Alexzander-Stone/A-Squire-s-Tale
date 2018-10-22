extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

var casting_animation_timer = 0
var timeToAnimate = 2
#current iteration: each ability has a number, enter determines animation, duration, etc. based on this
var abilityNumber = 0

func enter():
	casting_animation_timer = timeToAnimate
	
	# Will substitute with search for proper ability/animation.
	if(owner.crafting_container.size() > 0):
		for i in owner.crafting_container:
			print("Cast spell " + str(i))
	
	#code for implementing spell 1
	if(abilityNumber == 1)
		#select animation and play it
		#set timeToAnimate to the animation duration

func update(delta):
	if(casting_animation_timer >= 0):
		casting_animation_timer -= delta
	else:
		emit_signal("finished", "idling")
	
	# Call parent class function.
	.update(delta)