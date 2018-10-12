extends "res://State Machine/State.gd"

func enter():
	# Will substitute with search for proper ability/animation.
	if(owner.crafting_container.size() > 0):
		for i in owner.crafting_container:
			print("Cast spell " + str(i))
	emit_signal("finished", "idling")