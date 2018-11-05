# We use a .JSON file to store the valid combinations and 
# their scene paths for ability crafting.
extends Node

onready var primary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var secondary_spawner = preload("res://Scenes/Attack/Utility.tscn")
# Placeholders
onready var ternary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var super_spawner = preload("res://Scenes/Attack/Attack.tscn")

export(int) var primary_length = 1
export(int) var secondary_length = 1
export(int) var ternary_length = 1
export(int) var super_length = 1
# Replace with dictionary.
var crafting_length = 1

onready var follow_node = $"Follow"
onready var stay_node = $"Stay"

var craftable_abilities_dict = {}
var current_active_abilities = []

func _ready():
	var file = File.new()
	file.open("res://Assets/JSON/Player Abilities/PlayerAbilities.json", File.READ)
	var text_data = file.get_as_text()
	file.close()
	
	craftable_abilities_dict = parse_json(text_data)

# void setup_ability(Node new_node, String animation_to_play)
# Default setup for all nodes. Spawns on top of player and chooses correct animation.
# Immediately placed into scene tree to be viewed and a container for collection.
func setup_ability(new_node, animation_to_play):
	new_node.position = get_parent().position
	new_node.get_node("AnimationPlayer").play(animation_to_play)
	current_active_abilities.append(new_node)

func craft_ability(ability_key, animation_to_play):
	# Check to see if ability is valid.
	if craftable_abilities_dict.has(ability_key):
		var craft_spawner = load(craftable_abilities_dict[ability_key])
		var new_node = craft_spawner.instance()
		setup_ability(new_node, animation_to_play)
		# Hammer follows player.
		follow_node.add_child(new_node)

func spawn_primary(animation_to_play):
	var new_node = primary_spawner.instance()
	setup_ability(new_node, animation_to_play)
	# Hammer follows player.
	follow_node.add_child(new_node)

func spawn_secondary(animation_to_play):
	var new_node = secondary_spawner.instance()
	setup_ability(new_node, animation_to_play)
	# Spikes don't follow player.
	stay_node.add_child(new_node)

func spawn_ternary(animation_to_play):
	var new_node = ternary_spawner.instance()
	setup_ability(new_node, animation_to_play)
	follow_node.add_child(new_node)

func spawn_super(animation_to_play):
	var new_node = super_spawner.instance()
	setup_ability(new_node, animation_to_play)
	follow_node.add_child(new_node)