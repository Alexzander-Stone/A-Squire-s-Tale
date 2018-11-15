# Enemy will begin to "search", uses a animation player to direct the vision cone.
# Could use a tween, but for now this will do.

# Each step of the search is determine by the previous tween's completion (and signal).

# Rotation of sprite is for visual representation.
# Rotation of vision is for actual implementation.
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFollowable.gd"

export(NodePath) var tween_path
var tween_node

export(NodePath) var animated_sprite_path
var animated_sprite_node

##
#Vision path/node are inherited from Followable class.
##
#export(NodePath) var vision_path
#var vision_node

export(int) var rotation_of_vision
export(int) var rotation_of_character
var number_of_searches_left = 0
var search_step = 0

# Variables used during search steps.
var current_character_rotation
var current_vision_rotation
var rotate_character_to = 0
var rotate_vision_to = 0

func _ready():
	tween_node = get_node(tween_path)
	animated_sprite_node = get_node(animated_sprite_path)
	vision_node = get_node(vision_path)
	# Tween_completed returns object and nodepath to object.
	tween_node.connect("tween_completed", self, "next_search_step")

# To create some cool "AI", randomize how many times the animation is played and what direction it is played.
func enter(args):
	##
	#Replace with check to see which rotation values to begin with, based on animation frames.
	#
	current_character_rotation = 0
	current_vision_rotation = 0
	
	number_of_searches_left = rand_range(1, 4)
	setup_search_rotation(0)
	next_search_step(null, null)

# Clear any animations from playing.
# To make it not appear jagged, flinching state must have unique animation.
func exit():
	# May need to change to reset_all()
	tween_node.stop_all()

func set_tween_character_rotation_to(rotation_value, time):
	tween_node.interpolate_property(animated_sprite_node, 'rotation_degrees', current_character_rotation, rotation_value, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)

func set_tween_vision_rotation_to(rotation_value, time):
	tween_node.interpolate_property(vision_node, 'rotation_degrees', current_vision_rotation, rotation_value, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)

# Called from initial search initialization and tween animation completion.
# Determines which search step to perform next (or when to end the current search).
func next_search_step(object, node_path):
	# Update current rotation values.
	current_character_rotation = animated_sprite_node.rotation_degrees
	current_vision_rotation = vision_node.rotation_degrees
	
	# Tween is buggy when attempting to be used for multiple animations in a row.
	# Must stop all tweens when the tween has finished it's animations, or it will
	# bug out the timer.
	tween_node.stop_all()
	match(search_step):
		0:
			search_step_one()
		1:
			search_step_two()
		2:
			search_step_three()
		3:
			end_search()
	

func setup_search_rotation(go_to_rotation):
	# Update the character animation frames.
	# Vision rotation.
	set_tween_vision_rotation_to(go_to_rotation, 1)
	tween_node.start()
	
	# Update rotation starting points.
	##
	#Rotation of character is more unique than FoV, needs to be changed.
	##
	rotate_character_to = rotation_of_character
	rotate_vision_to = go_to_rotation
	
	tween_node.start()

func search_step_one():
	# Character rotation.
	#set_tween_character_rotation_to(rotate_character_to, 1)
	# Vision rotation.
	set_tween_vision_rotation_to(rotate_vision_to + rotation_of_vision, 1)
	
	tween_node.start()
	
	search_step += 1

func search_step_two():
	# Character rotation.
	#set_tween_character_rotation_to(-rotate_character_to, 2)
	# Vision rotation.
	set_tween_vision_rotation_to(rotate_vision_to - rotation_of_vision, 2)
	
	tween_node.start()
	search_step += 1

func search_step_three():
	# Character rotation.
	#set_tween_character_rotation_to(current_character_rotation + rotate_character_to, 1)
	# Vision rotation.
	set_tween_vision_rotation_to(rotate_vision_to, 1)
	
	tween_node.start()
	search_step += 1

# Reset the searching values back to original.
# When the animation ends, determine which direction to play the next animation or to transition back to idle.
func end_search():
	search_step = 0
	
	number_of_searches_left -= 1
	if number_of_searches_left > 0:
		# Find a random direction to begin searching.
		var direction_to_look = (randi() % 4) * 90
		setup_search_rotation(direction_to_look)
	else:
		emit_signal("finished", "idling", [])

func player_found(player_collision_node, node_path):
	emit_signal("finished", "following", [player_collision_node.position])