extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

# ability_key : String path to scene of animation to play.
# animation_to_play : String key ID for the PlayerAbilities.JSON file.
signal crafting_used(ability_key, animation_to_play)

export(NodePath) var cooldown_path
export(NodePath) var abilities_path
export(NodePath) var animated_sprite_path

onready var cooldown_node = get_node(cooldown_path)
onready var abilities_node = get_node(abilities_path)
onready var owner_node = owner
onready var animated_sprite_node = get_node(animated_sprite_path)

var dict = {"00" : "Attack_1R", 
			"10" : "Attack_1R", 
			"11" : "Attack_1DR", 
			"01" : "Attack_1D", 
			"-11" : "Attack_1DL", 
			"-10" : "Attack_1L", 
			"-1-1" : "Attack_1TL", 
			"0-1" : "Attack_1T", 
			"1-1" : "Attack_1TR"}

var casting_animation_timer = 0
# Needs to be replaced by ability lengths eventually.
var timeToAnimate = 2

func _ready():
	self.connect("crafting_used", abilities_node, "craft_ability")

# Determine which ability to use, based on the PlayerAbilities.JSON file.
# Each ability will have a unique key ID, weapon indicator animation, and casting timer.
func enter(args):
	.enter(args)
	
	# Verify that the player hasn't entered the casting state without abilities being used.
	if args[0] == -1 and owner.crafting_container.size() <= 0:
		emit_signal("finished", "idling", [])
	
	# No crafting involved, single input and straight to casting.
	if((args[0] != -1)):
		owner.crafting_container.append(args[0])
	
	# While creating the ability_key string, check to see if ability cooldowns are 
	# will prevent it from being created. 
	# Accounts for crafting abilities when given one input.
	var ability_key = ""
	while owner.crafting_container.size() > 0:
		var i = owner.crafting_container.pop_front()
		if cooldown_node.is_cooldown_running_for(i) == true:
			return
		ability_key += String(i)

	var weapon_animation_to_play = dict[str(round(owner_node.direction_vector[0])) + str(round(owner_node.direction_vector[1]))]
	emit_signal("crafting_used", ability_key, weapon_animation_to_play)

	if abilities_node.craftable_abilities_dict.has(ability_key):
		casting_animation_timer = float(abilities_node.craftable_abilities_dict[ability_key]["casting_timer"])
		animated_sprite_node.animation = abilities_node.craftable_abilities_dict[ability_key]["character_animation"]

func update(delta):
	if(casting_animation_timer >= 0):
		casting_animation_timer -= delta
	else:
		##
		# May want to implement pushdown automata to return to previous running state.
		##
		emit_signal("finished", "idling", [])
	
	# Call parent class function.
	.update(delta)