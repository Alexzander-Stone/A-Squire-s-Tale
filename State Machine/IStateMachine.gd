extends Node

signal state_changed(current_state)

export(NodePath) var START_STATE
var states_map = {}

var states_pushdown_stack = []
var current_state = null
# Auto defined setter and getter.
var _active = false setget set_active

func _ready():
	for child in get_children():
		child.connect("finished", self, "_change_state")
	initialize(START_STATE)

# Reinitialize data, useful since nodes are never removed so data isn't automatically
# reset.
func initialize(start_state):
	set_active(true)
	states_pushdown_stack.push_front(get_node(start_state))
	current_state = states_pushdown_stack[0]
	current_state.enter()

func set_active(value):
	_active = value
	set_process_input(value)
	if not _active:
			states_pushdown_stack = []
			current_state = null

# Passes the inputs by the player to the current state (idle, move).
func _input(event):
	current_state.handle_input(event)

func _process(delta):
	current_state.update(delta)

func _on_animation_finished(anim_name):
	if not _active:
		return
	current_state._on_animation_finished(anim_name)

func _change_state(state_name):
	if not _active:
		return
	current_state.exit()
	
	if state_name == "previous":
		states_pushdown_stack.pop_front()
	else:
		states_pushdown_stack[0] = states_map[state_name]
	
	current_state = states_pushdown_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()