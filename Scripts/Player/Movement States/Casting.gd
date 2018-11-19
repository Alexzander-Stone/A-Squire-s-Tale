extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

signal primary_used(animation_to_play)
signal secondary_used(animation_to_play)
signal ternary_used(animation_to_play)
signal super_used(animation_to_play)
# Ability key = Abilities numbers used for crafting.
signal crafting_used(ability_key, animation_to_play)

export(NodePath) var cooldown_path
export(NodePath) var abilities_path
export(NodePath) var weapon_animation_path
export(NodePath) var parent_path

onready var cooldown_node = get_node(cooldown_path)
onready var abilities_node = get_node(abilities_path)
onready var parent_node = get_node(parent_path)

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
	self.connect("primary_used", abilities_node, "spawn_primary")
	self.connect("secondary_used", abilities_node, "spawn_secondary")
	self.connect("ternary_used", abilities_node, "spawn_ternary")
	self.connect("super_used", abilities_node, "spawn_super")
	self.connect("crafting_used", abilities_node, "craft_ability")


func enter(args):
	.enter(args)
	##
	#Add check to see if crafting container only has one ability.
	#May want to just immediately call normal crafting if so.
	##
	if(args.size() > 0):
		if(owner.crafting_container.size() > 0 && args[0] == 0):
			# While creating the ability_key string, check to see if ability cooldowns are 
			# will prevent it from being created. 
			var ability_key = ""
			while owner.crafting_container.size() > 0:
				var i = owner.crafting_container.pop_front()
				if cooldown_node.is_cooldown_running_for(i) == true:
					return
				ability_key += String(i)
			var animation_to_play = dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))]
			emit_signal("crafting_used", ability_key, animation_to_play)
			# Get casting_animation_timer from Abilities node.
			if abilities_node.craftable_abilities_dict.has(ability_key):
				casting_animation_timer = float(abilities_node.craftable_abilities_dict[ability_key]["casting_timer"]);
		
		#receive input for primary ability (number 1)
		elif(args[0] == 1 && cooldown_node.primary_cooldown_timer <= 0):
			var animation_to_play = dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))]
			emit_signal("primary_used", animation_to_play)
			casting_animation_timer = abilities_node.primary_length;
		
		#receive input for secondary ability (number 2)
		elif(args[0] == 2 && cooldown_node.secondary_cooldown_timer <= 0):
			var animation_to_play = dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))]
			emit_signal("secondary_used", animation_to_play)
			#set timeToAnimate to the animation duration
			# Need to replace with inheritable helper method.
			
			# Get casting_animation_timer from Abilities node.
			casting_animation_timer = abilities_node.secondary_length;
			
		elif(args[0] == 3 && cooldown_node.ternary_cooldown_timer <= 0):
			var animation_to_play = dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))]
			emit_signal("ternary_used", animation_to_play)
			#set timeToAnimate to the animation duration
			# Need to replace with inheritable helper method.
			
			# Get casting_animation_timer from Abilities node.
			casting_animation_timer = abilities_node.ternary_length;
			
		else:
			print("no casting")
			emit_signal("finished", "idling", [])

func update(delta):
	if(casting_animation_timer >= 0):
		casting_animation_timer -= delta
	else:
		emit_signal("finished", "idling", [])
	
	# Call parent class function.
	.update(delta)
	
func exit():
	.exit()