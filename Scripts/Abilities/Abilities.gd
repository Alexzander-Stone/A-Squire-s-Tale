extends Node

var current_active_abilities = []

export(int) var primary_length = 1
export(int) var secondary_length = 1
export(int) var ternary_length = 1
export(int) var super_length = 1

onready var follow_node = $"Follow"
onready var stay_node = $"Stay"

onready var primary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var secondary_spawner = preload("res://Scenes/Attack/Utility.tscn")
# Placeholders
onready var ternary_spawner = preload("res://Scenes/Attack/Attack.tscn")
onready var super_spawner = preload("res://Scenes/Attack/Attack.tscn")

# void setup_ability(Node new_node, String animation_to_play)
# Default setup for all nodes. Spawns on top of player and chooses correct animation.
# Immediately placed into scene tree to be viewed and a container for collection.
func setup_ability(new_node, animation_to_play):
	new_node.position = get_parent().position
	new_node.get_node("AnimationPlayer").play(animation_to_play)
	current_active_abilities.append(new_node)

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