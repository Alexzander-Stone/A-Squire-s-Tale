extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

signal primary_used()
signal secondary_used()
signal ternary_used()
signal super_used()

var ability_node

var casting_animation_timer = 0
var timeToAnimate = 2

func _ready():
	ability_node = $"../../Abilities"

func enter(args):
	# Will substitute with search for proper ability/animation.
	#if args == 0, we have a combo spell, so we use the crafting container
	if(owner.crafting_container.size() > 0 && args[0] == 0):
		casting_animation_timer = timeToAnimate;
		for i in owner.crafting_container:
			print("Cast spell " + str(i))
	
	#receive input for primary ability (number 1)
	#add condition checking for cooldown
	if(args[0] == 1 && ability_node.primary_cooldown_timer <= 0):
		#select animation and play it
		print("first ability activate")
		emit_signal("primary_used")
		#set timeToAnimate to the animation duration
		casting_animation_timer = 1;
	else:
		print("no casting")
		emit_signal("finished", "idling", [0])

func update(delta):
	if(casting_animation_timer >= 0):
		casting_animation_timer -= delta
	else:
		emit_signal("finished", "idling", [0])
	
	# Call parent class function.
	.update(delta)