extends "res://State Machine/State.gd"

func handle_input(event):
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left") || event.is_action_pressed("ui_up") || event.is_action_pressed("ui_down"):
		emit_signal("finished", "walking", [0])
	return .handle_input(event)

func update(delta):
	# Change to use episilon in the future.
	if (floor(owner.velocity.x) == 0 && floor(owner.velocity.y) == 0):
		emit_signal("finished", "idling", [0])
	else:
		if(owner.velocity.x > 0):
			owner.velocity.x -= 1 * delta
		elif(owner.velocity.x < 0):
			owner.velocity.x += 1 * delta
		if(owner.velocity.y > 0):
			owner.velocity.y -= 1 * delta
		elif(owner.velocity.y < 0):
			owner.velocity.y += 1 * delta
	owner.update_position()