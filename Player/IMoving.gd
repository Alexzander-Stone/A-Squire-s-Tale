extends "res://State Machine/State.gd"

func fillJustPressedArray(array):
	array[0] = int(Input.is_action_just_pressed("ui_left"))
	array[1] = int(Input.is_action_just_pressed("ui_right"))
	array[2] = int(Input.is_action_just_pressed("ui_up"))
	array[3] = int(Input.is_action_just_pressed("ui_down")) 

func fillPressedArray(array):
	array[0] = int(Input.is_action_pressed("ui_left"))
	array[1] = int(Input.is_action_pressed("ui_right"))
	array[2] = int(Input.is_action_pressed("ui_up"))
	array[3] = int(Input.is_action_pressed("ui_down")) 