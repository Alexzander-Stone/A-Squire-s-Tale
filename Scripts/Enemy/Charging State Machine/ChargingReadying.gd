extends "res://Scripts/State Machine/State.gd"
#extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

# Base direction on passed player object.
# Take in a direction to begin moving back towards.
# Needed for gradient eventually too.

# The key from the tween signals can be used to identify what action to take upon completion

# If at anytime we collide with a wall, stop the portions of code that are moving.
# To pop out the other side, just use move and slide on the direction that 
# we back up to immediately pop out the wall.
##
#OR
##
# Calculate exactly how far we can go back and use that instead, that way we still have the jumps but they will end earlier.
# To do this, just send out a ray to the maximum length in the direction that we are jumping back, if it hits a wall decrease it by some length
# (make sure to base this length on the current direction length [increment could be like Vector2(0.6, 0.4)]).
# Then just divide this number by 3 to assign to each jump (or make first jump half and the two later jumps fourths).

# If we don't like having multiple tween nodes, we can always procedurally create them when needed.

##
# The issues with collisions on the tilemap (46 square vs 16) are causing issues when finding the colliding point.
## 

export(NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(NodePath) var animated_sprite_path
onready var animated_sprite_node = get_node(animated_sprite_path)

export(NodePath) var raycast_path
onready var raycast_node = get_node(raycast_path)

export(int) var jump_height = 40
export(float) var jump_time = 1

export(int) var backup_length = 250

export(float) var large_backup_height = 20
export(float) var large_bounce_time = 1
export(float) var large_bounce_count = 1.0

export(float) var small_backup_height = 10
export(float) var small_bounce_time = 1
export(float) var small_bounce_count = 2.0

# Direction will always be normalized
var player_position = Vector2(1.1, 1.1)
var direction_to_player = Vector2(-1.1, 1.1)

var current_animation_index = 0
var raycasted_target = Vector2(0.1,0.1)

# Used for 3 bounce setup.
var bounce_position = Vector2(0.1,0.1)

# args[0] = player's perceived position.
func enter(args):
	# Reset values.
	current_animation_index = 0
	
	# Record player position.
	player_position = args[0]
	direction_to_player = (player_position - owner.position).normalized()
	
	# Attach signals.
	tween_node.connect("tween_completed", self, "animation_transitions")
	##
	#Emit smoke particle.
	##
	
	# Tween to jump up.
	animate_vertically(-jump_height, jump_time)
	
	# Turn red while doing this.
	

func exit():
	#Detach signals.
	tween_node.disconnect("tween_completed", self, "animation_transitions")

func animation_transitions(tween_object, inspector_key):
	# Update animation index.
	current_animation_index += 1
	
	# Fall down from jump. +2 to current_animation_index
	
	# Jumping animation collection has finished, begin backing up.
	# Bounce back in 3 chunks.
	# Calculate how far to back up and the portion that each bounce gets.
	# Find this by using the the vector opposite to our direction.
	if current_animation_index == 2:
		var bounce_direction = -direction_to_player
		var bounce_length = backup_length
		# Check to see a raycast in the bounce direction would end up in
		# a wall, if so find the closest position to bounce towards.
		bounce_position = bounce_direction * bounce_length
		print("bounce pos is " + str(bounce_position))
		#raycast_node.position = owner.position
		raycast_node.set_cast_to(bounce_position)
		
		raycast_node.force_raycast_update()
		
		# Find the closest point that isn't being occupied to jump to.
		while raycast_node.is_colliding():
			bounce_position -= bounce_direction
			raycast_node.set_cast_to(bounce_position)
			raycast_node.force_raycast_update()
		# Determine how far to charge.
		raycasted_target = bounce_position
		# Begin first bounce. Contains two tween processes, so next 
		# animation index will be +2.
		bounce_to(owner.position, bounce_position * (2.0/3.0), -large_backup_height, large_bounce_count, large_bounce_time)
	
	# Smaller jumps, will have 2 jumps so animation index will be +4
	elif current_animation_index == 4:
		bounce_to(owner.position, bounce_position * (1.0/3.0), -small_backup_height, small_bounce_count, small_bounce_time)
	
	# After final chunk, shake/hop. This is final animation
	
	# Check to see if final animation has ended, then charge.
	elif current_animation_index == 8:
		emit_signal("finished", "attacking", [player_position, raycasted_target])

# Tween animated sprite to a new y position in a specified time frame.
# void animate_vertically(delta_y, time_frame)
# delta_y = amount to change animated sprite's y position by. Can be negative to move up.
# time_frame = length of animation
func animate_vertically(delta_y, time_frame):
	var current_position = animated_sprite_node.position
	var go_to_position = Vector2(current_position.x, current_position.y + delta_y)
	tween_node.interpolate_property(animated_sprite_node, 'position', current_position, go_to_position, time_frame/2.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween_node.interpolate_property(animated_sprite_node, 'position', go_to_position, current_position, time_frame/2.0, Tween.TRANS_QUAD, Tween.EASE_IN, time_frame/2.0)
	tween_node.start()

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
		tween_node.interpolate_property(animated_sprite_node.owner, 'position', current_position, apex_jump_pos, time_frame/(2.0 * number_of_bounces), Tween.TRANS_QUAD, Tween.EASE_IN, (time_frame/(2.0 * number_of_bounces)) * i)
		# Go to ground.
		tween_node.interpolate_property(animated_sprite_node.owner, 'position', apex_jump_pos, ending_jump_pos, time_frame/(2.0 * number_of_bounces), Tween.TRANS_QUAD, Tween.EASE_OUT, (time_frame/(2.0 * number_of_bounces)) * (1+i))
		i += 2
	tween_node.start()