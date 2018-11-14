extends "res://Scripts/State Machine/IStateMachine.gd"

func _ready():
	states_map = {
		"idling": $Idling,
		"searching": $Searching,
		"walking": $Walking,
		"following": $Following,
		"charging": $Charging,
		"taking damage": $"Taking Damage",
		"dying": $Dying
	}