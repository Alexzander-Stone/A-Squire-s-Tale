extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

signal primary_used()
signal secondary_used()
signal ternary_used()
signal super_used()

var ability_node
var weapon_animation_node
var parent_node
var dict = {"10" : "Primary_Attack_1R", "11" : "Primary_Attack_1DR", "01" : "Primary_Attack_1D", "-11" : "Primary_Attack_1DL", "-10" : "Primary_Attack_1L", "-1-1" : "Primary_Attack_1TL", "0-1" : "Primary_Attack_1T", "1-1" : "Primary_Attack_1TR"}

var casting_animation_timer = 0
var timeToAnimate = 2

func _ready():
	ability_node = $"../../Abilities"
	weapon_animation_node = $"../../Weapon/AnimationPlayer"
	parent_node = $"../.."

func enter(args):
	#if args == 0, we have a combo spell, so we use the crafting container
	if(owner.crafting_container.size() > 0 && args[0] == 0):
		casting_animation_timer = timeToAnimate;
		for i in owner.crafting_container:
			print("Cast spell " + str(i))
	
	#receive input for primary ability (number 1)
	#add condition checking for cooldown
	if(args[0] == 1 && ability_node.primary_cooldown_timer <= 0):
		#select animation and play it. Rotate based on player's current direction.
		weapon_animation_node.play(dict[str(round(parent_node.direction_vector[0])) + str(round(parent_node.direction_vector[1]))])
		print("first ability activate")
		emit_signal("primary_used")
		#set timeToAnimate to the animation duration
		casting_animation_timer = weapon_animation_node.current_animation_length;
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