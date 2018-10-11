extends Label

signal state_changed(current_state)

var state_machine

func _ready():
	state_machine = owner.find_node("StateMachine")
	state_machine.connect("state_changed", self, "change_state_name")
	text = str(state_machine.current_state.name)

func change_state_name(current_state):
	text = str(current_state.name)