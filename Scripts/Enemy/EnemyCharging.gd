#extends "res://Scripts/State Machine/State.gd"
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

export(NodePath) var initial_node_path

var states_map
var current_state

func _ready():
	states_map = {
		"readying": $Readying,
		"attacking": $Attacking,
		"ending": $Ending
	}
	for state in get_children():
		state.connect("finished", self, "change_state")

func enter(args):
	current_state = get_node(initial_node_path)
	current_state.enter(args)
	.enter(args)

func update(delta):
	current_state.update(delta)

# Called when finished signal from substates is emitted. 
# Includes the next state name to use.
func change_state(state_name, args):
	# Exit out of current_state.
	current_state.exit()
	
	# Once charging is done, return to idling.
	if state_name == "leaving":
		emit_signal("finished", "idling", [])
	else:
		# Change states.
		current_state = states_map[state_name]
		# Officially enter new state.
		current_state.enter(args)