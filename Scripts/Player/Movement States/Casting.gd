extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

signal primary_used()
signal secondary_used()
signal ternary_used()
signal super_used()

export(NodePath) var cooldown_path
export(NodePath) var abilities_path
export(NodePath) var weapon_animation_path
export(NodePath) var parent_path

onready var cooldown_node = get_node(cooldown_path)
onready var abilities_node = get_node(abilities_path)
onready var weapon_animation_node = get_node(weapon_animation_path)
onready var parent_node = get_node(parent_path)

var dict = {"00" : "Primary_Attack_1R", "10" : "Primary_Attack_1R", "11" : "Primary_Attack_1DR", "01" : "Primary_Attack_1D", "-11" : "Primary_Attack_1DL", "-10" : "Primary_Attack_1L", "-1-1" : "Primary_Attack_1TL", "0-1" : "Primary_Attack_1T", "1-1" : "Primary_Attack_1TR"}

var casting_animation_timer = 0
# Needs to be replaced by ability lengths eventually.
var timeToAnimate = 2

func _ready():
	self.connect("primary_used", abilities_node, "spawn_primary")
	self.connect("secondary_used", abilities_node, "spawn_secondary")
	self.connect("ternary_used", abilities_node, "spawn_ternary")
	self.connect("super_used", abilities_node, "spawn_super")


func enter(args):
	if(args.size() > 0):
		#if args == 0, we have a combo spell, so we use the crafting container
		if(owner.crafting_container.size() > 0 && args[0] == 0):
			casting_animation_timer = timeToAnimate;
			for i in owner.crafting_container:
				print("Cast spell " + str(i))
		
		#receive input for primary ability (number 1)
		#add condition checking for cooldown
		if(args[0] == 1 && cooldown_node.primary_cooldown_timer <= 0):
			emit_signal("primary_used")
			#select animation and play it. Rotate based on player's current direction.
			weapon_animation_node.play(dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))])
			print("first ability activate")
			#set timeToAnimate to the animation duration
			# Need to replace with inheritable helper method.
			
			# Get casting_animation_timer from Abilities node.
			casting_animation_timer = weapon_animation_node.current_animation_length / weapon_animation_node.playback_speed;
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