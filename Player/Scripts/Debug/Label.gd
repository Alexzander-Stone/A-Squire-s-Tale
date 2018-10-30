extends Label

signal state_changed(current_state)

export(NodePath) onready var state_machine_path
var state_machine_node

func _ready():
	state_machine_node = get_node(state_machine_path)
	state_machine_node.connect("state_changed", self, "change_state_name")
	text = str(state_machine_node.current_state.name)

func change_state_name(current_state):
	text = str(current_state.name)