extends Node

export (NodePath) var state_machine_path
onready var state_machine_node = get_node(state_machine_path)
var current_sfx = ""

func _ready():
	state_machine_node.connect("state_changed", self, "trigger_sfx_hit", [])

func play():
	if(current_sfx != ""):
		get_node(current_sfx).play()
	else:
		print("No sfx selected.")

func stop():
	if(current_sfx != ""):
		get_node(current_sfx).stop()
	else:
		print("No song selected.")

func play_sfx(sfx):
	if(current_sfx != ""):
		stop()
	current_sfx = sfx
	play()

func trigger_sfx_hit(state):
	if(state.name == "Flinching"):
		play_sfx("hit_react_medium")
