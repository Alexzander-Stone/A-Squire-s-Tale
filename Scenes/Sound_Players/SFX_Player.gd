extends Node

export (NodePath) var state_machine_path
onready var state_machine_node = get_node(state_machine_path)
export (NodePath) var ability_node_path
onready var ability_node = get_node(ability_node_path)
var current_sfx = ""

func _ready():
	state_machine_node.connect("state_changed", self, "trigger_sfx_hit", [])
	ability_node.connect("primary_used", self, "trigger_sfx_ability_primary", [])
	ability_node.connect("secondary_used", self, "trigger_sfx_ability_secondary", [])
	ability_node.connect("ternary_used", self, "trigger_sfx_ability_ternary", [])
	ability_node.connect("super_used", self, "trigger_sfx_ability_super", [])

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

func trigger_sfx_ability_primary(ah):
	#hammer (weapon_swing)
	play_sfx("weapon_swing")

func trigger_sfx_ability_secondary(ah):
	#slam (weapon_swing_large)
	play_sfx("weapon_swing_large")
      
func trigger_sfx_ability_ternary(ah):
	#shout (battle_cry)
	play_sfx("battle_cry")
      
func trigger_sfx_ability_super(ah):
	#jump (loud_thud)
	play_sfx("loud_thud")

func trigger_sfx_hit(state):
	if(state.name == "Flinching"):
		var r = randi()
		if(r % 3):
			play_sfx("hit_react_large")
		elif(r % 2): 
			play_sfx("hit_react_medium")
		else:
			play_sfx("hit_react_small")
	elif(state.name == "Dying"):
		play_sfx("death")