extends "res://State Machine/IStateMachine.gd"

func _ready():
	states_map = {
		"idling": $Idling,
		"walking": $Walking
	}