# Enemy will begin to "search", uses a animation player to direct the vision cone.
# Could use a tween, but for now this will do.

# Each step of the search is determine by the previous tween's completion (and signal).

# Rotation of sprite is for visual representation.
# Rotation of vision is for actual implementation.
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFollowable.gd"

export(NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(NodePath) var animated_sprite_path
onready var animated_sprite_node = get_node(animated_sprite_path)
export(NodePath) var vision_path
onready var vision_node = get_node(vision_path)

export(int) var rotation_of_vision
export(int) var rotation_of_character
var number_of_searches_left = 0
var search_step = 0

# Variables used during search steps.
var rotate_character_to
var rotate_vision_to 

func _process(delta):
	print(tween_node.is_active())
	print(tween_node.tell())

func _ready():
	# Tween_completed returns object and nodepath to object.
	tween_node.connect("tween_completed", self, "next_search_step")

# To create some cool "AI", randomize how many times the animation is played and what direction it is played.
func enter(args):
	number_of_searches_left = rand_range(1, 4)
	next_search_step(null, null)

# Clear any animations from playing.
# To make it not appear jagged, flinching state must have unique animation.
func exit():
	tween_node.stop_all()

func next_search_step(object, node_path):
	# Tween is buggy when attempting to be used for multiple animations in a row.
	# Must stop all tweens when the tween has finished it's animations, or it will
	# bug out the timer.
	tween_node.stop_all()
	match(search_step):
		0:
			setup_search()
			search_step_one()
		1:
			search_step_two()
		2:
			search_step_three()
		3:
			end_search()
	

func setup_search():
	# Change the rotation of character and vision.
	rotate_character_to = rotation_of_character
	rotate_vision_to = rotation_of_vision

# Reset the searching values back to original.
# When the animation ends, determine which direction to play the next animation or to transition back to idle.
func end_search():
	search_step = 0
	
	number_of_searches_left -= 1
	if number_of_searches_left > 0:
		next_search_step(null, null)
	else:
		emit_signal("finished", "idling", [])

func search_step_one():
	# Character rotation.
	tween_node.interpolate_property(animated_sprite_node, 'rotation_degrees', animated_sprite_node.rotation, rotate_character_to, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Vision rotation.
	tween_node.interpolate_property(vision_node, 'rotation_degrees', vision_node.rotation, rotate_vision_to, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween_node.start()
	
	search_step += 1

func search_step_two():
	# Character rotation.
	tween_node.interpolate_property(animated_sprite_node, 'rotation_degrees', rotate_character_to, -rotate_character_to, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Vision rotation.
	tween_node.interpolate_property(vision_node, 'rotation_degrees', rotate_vision_to, -rotate_vision_to, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween_node.start()
	
	search_step += 1

func search_step_three():
	# Character rotation.
	tween_node.interpolate_property(animated_sprite_node, 'rotation_degrees', -rotate_character_to, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Vision rotation.
	tween_node.interpolate_property(vision_node, 'rotation_degrees', -rotate_vision_to, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween_node.start()
	
	search_step += 1