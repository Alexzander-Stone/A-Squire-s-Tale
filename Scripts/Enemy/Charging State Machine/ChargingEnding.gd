extends "res://Scripts/State Machine/State.gd"

export(NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(int) var bounce_height = 10
export(int) var number_of_bounces = 3
export(float) var animation_time = .5

var current_animation_index = 0

# args[0] = charge vector, direction we were charging towards.
# Only valid when Rat has hit something (wall, player, etc.)
func enter(args):
	# Reset animation index.
	current_animation_index = 0
	tween_node.connect("tween_completed", self, "animation_transitions")
	
	# If the Rat has hit a wall or player, bounce off it.
	if args.size() > 0:
		var bounce_back_vect = -(args[0].normalized()) 
		bounce_to(owner.position, owner.position + bounce_back_vect, bounce_height, number_of_bounces, animation_time)
	# Otherwise, the rat has ended at nothing and can immediately signal the ending of the charge.
	else:
		emit_signal("finished", "leaving", [])

func exit():
	#Detach signals.
	tween_node.disconnect("tween_completed", self, "animation_transitions")

func animation_transitions(tween_object, inspector_key):
	# Update animation index.
	current_animation_index += 1
	
	if current_animation_index == 2 * number_of_bounces:
		emit_signal("finished", "leaving", [])

# Can bounce multiple times.
# Takes a local bounce pos
func bounce_to(position, bounce_pos, bounce_height, number_of_bounces, time_frame):
	var ending_jump_pos = position
	var distance_vector_per_jump = bounce_pos / (2.0 * number_of_bounces)
	var i = 0
	while i < number_of_bounces*2:
		var current_position = ending_jump_pos
		var apex_jump_pos = Vector2(current_position.x + distance_vector_per_jump.x, current_position.y + distance_vector_per_jump.y + bounce_height)
		ending_jump_pos = Vector2(apex_jump_pos.x + distance_vector_per_jump.x, apex_jump_pos.y + distance_vector_per_jump.y - bounce_height)
		# Go to apex.
		tween_node.interpolate_property(owner, 'position', current_position, apex_jump_pos, time_frame/(2.0 * number_of_bounces), Tween.TRANS_QUAD, Tween.EASE_IN, (time_frame/(2.0 * number_of_bounces)) * i)
		# Go to ground.
		tween_node.interpolate_property(owner, 'position', apex_jump_pos, ending_jump_pos, time_frame/(2.0 * number_of_bounces), Tween.TRANS_QUAD, Tween.EASE_OUT, (time_frame/(2.0 * number_of_bounces)) * (1+i))
		i += 2
	tween_node.start()