extends "res://State Machine/State.gd"

func handle_input(event):
	if event.is_action_pressed("select_coin"):
		owner.has_selected = owner.grid_interaction.select_coins(owner.grid_position)
	if event.is_action_pressed("deselect_coin"):
		if owner.has_selected == true:
			owner.has_selected = !owner.grid_interaction.deselect_coins(owner.grid_position) 
	return .handle_input(event)