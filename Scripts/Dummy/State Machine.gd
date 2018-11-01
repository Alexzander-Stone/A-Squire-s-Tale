extends "res://Scripts/State Machine/IStateMachine.gd"

func _ready():
	states_map = {
		"idling": $Idling,
		"flinching": $Flinching,
		"dying": $Dying,
	}