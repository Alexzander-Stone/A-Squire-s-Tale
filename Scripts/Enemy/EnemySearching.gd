# Enemy will begin to "search", uses a animation player to direct the vision cone.
# Could use a tween, but for now this will do.

# Rotation of sprite is for visual representation.
# Rotation of vision is for actual implementation.
extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFollowable.gd"

export(NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(NodePath) var animated_sprite_path
onready var animated_sprite_node = get_node(animated_sprite_path)
export(NodePath) var vision_path
onready var vision_node = get_node(vision_path)

var number_of_searches
export(int) var rotation_of_vision
export(int) var rotation_of_character

# To create some cool "AI", randomize how many times the animation is played and what direction it is played.
func enter(args):
	number_of_searches = rand_range(1, 4)
	begin_search()

# When the animation ends, determine which direction to play the next animation.





func begin_search():
	# Determine animation for label. Find random location to go towards.
	var newX = randi()%81 if randi() % 2 == 0 else -randi()%81
	var newY = randi()%81 if randi() % 2 == 0 else -randi()%81
	
	# Change the rotation of character and vision.
	var rotate_character_to = rotation_of_character
	var rotate_vision_to = rotation_of_vision
	# Characte rotation.
	tween_node.interpolate_property(animated_sprite_node, 'rotation_degrees', animated_sprite_node.rotation, rotate_character_to, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	# Vision rotation.
	tween_node.interpolate_property(vision_node, 'rotation_degrees', vision_node.rotation, rotate_vision_to, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween_node.start()