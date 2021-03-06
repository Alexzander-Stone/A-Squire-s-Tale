extends "res://Scripts/State Machine/IStateMachine.gd"

func _ready():
	states_map = {
		"idling": $Idling,
		"walking": $Walking,
		"stopping": $Stopping,
		"running": $Running,
		"crafting": $Crafting,
		"casting": $Casting,
		"flinching": $Flinching,
		"dying": $Dying
	}