extends "res://Player/Scripts/Movement States/Inheritable Classes/IFlinchable.gd"

#in here we need to add animation, damage numbers, and HP loss

var flinchTimer = 0
var timeToFlinch = 1
onready var dummy_animation_node = $"../../AnimationPlayer"

func enter(args):
	#args is the damage value, use it to display, don't edit hp
	dummy_animation_node.play("Flinching")
	print("Dummy State: hit")
	flinchTimer = dummy_animation_node.current_animation_length / dummy_animation_node.playback_speed

func update(delta):
	if(flinchTimer > 0):
		flinchTimer -= delta
	else:
		emit_signal("finished", "idling", [0])
	.update(delta)