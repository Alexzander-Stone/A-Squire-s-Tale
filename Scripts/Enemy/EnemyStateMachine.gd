extends "res://Scripts/State Machine/IStateMachine.gd"

func _ready():
	states_map = {
		"idling": $Idling,
		"walking": $Walking,
		"Charging": $Charging,
		"flinching": $"Taking Damage",
		"dying": $Dying
	}