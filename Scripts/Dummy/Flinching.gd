extends "res://Scripts/Player/Movement States/Inheritable Classes/IFlinchable.gd"

#in here we need to add animation, damage numbers, and HP loss

var flinchTimer = 0
var timeToFlinch = 1

export(NodePath) var dummy_path
export(NodePath) var dummy_animation_path

onready var dummy_node = get_node(dummy_path)
onready var dummy_animation_node = get_node(dummy_animation_path)

func enter(args):
	dummy_node.take_damage(args[0])
	#args is the damage value, use it to display, don't edit hp
	dummy_animation_node.play("Flinching")
	#print("Dummy State: hit")
	flinchTimer = dummy_animation_node.current_animation_length / dummy_animation_node.playback_speed
	.enter(args)

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [])
	.update(delta)
	
func exit():
	.exit()