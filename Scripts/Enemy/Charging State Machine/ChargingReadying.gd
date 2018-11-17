extends "res://Scripts/State Machine/State.gd"

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
export(float) var jump_time = 2
export(int) var backup_length = 500
export(float) var backup_height = 20
export(float) var bounce_time = 1

# Direction will always be normalized
var direction = Vector2(-1,0)

var current_animation_index = 0

# Used for 3 bounce setup.
var bounce_position

func enter(args):
	# Attach signals.
	tween_node.connect("tween_completed", self, "animation_transitions")
	##
	#Emit smoke particle.
	##
	
	# Tween to jump up.
	animate_vertically(-jump_height, jump_time/2.0)
	
	# Turn red while doing this.
	

func exit():
	#Detach signals.
	tween_node.disconnect("tween_completed", self, "animation_transitions")

func animation_transitions(tween_object, inspector_key):
	# Fall down from jump.
	if current_animation_index == 0:
		animate_vertically(jump_height, jump_time/2.0)
	
	# Jumping animation collection has finished, begin backing up.
	# Bounce back in 3 chunks.
	# Calculate how far to back up and the portion that each bounce gets.
	# Find this by using the the vector opposite to our direction.
	elif current_animation_index == 1:
		var bounce_direction = -direction
		var bounce_length = backup_length
		# Check to see a raycast in the bounce direction would end up in
		# a wall, if so find the closest position to bounce towards.
		bounce_position = bounce_direction * bounce_length
		print("initial bounce_position is " + str(bounce_position))
		raycast_node.set_cast_to(bounce_position)
		
		raycast_node.force_raycast_update()
		
		if raycast_node.is_colliding():
			# Returns collision shape that we are colliding with.
			bounce_position = raycast_node.get_collision_point()
		print("after raycast bounce_position is " + str(bounce_position))
		# Begin first bounce.
		bounce_to(bounce_position/2, -backup_height, bounce_time)
	
	
	
	
	# After final chunk, shake/hop. This is final animation
	
	# Check to see if final animation has ended, then charge.
	
	# Update animation index.
	current_animation_index += 1
	pass

# Tween animated sprite to a new y position in a specified time frame.
# void animate_vertically(delta_y, time_frame)
# delta_y = amount to change animated sprite's y position by. Can be negative to move up.
# time_frame = length of animation
func animate_vertically(delta_y, time_frame):
	var current_position = animated_sprite_node.position
	var go_to_position = Vector2(current_position.x, current_position.y + delta_y)
	tween_node.interpolate_property(animated_sprite_node, 'position', current_position, go_to_position, time_frame, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween_node.start()

func bounce_to(bounce_pos, bounce_height, time_frame):
	# Go to apex.
	var current_position = animated_sprite_node.position
	var jump_pos = Vector2(bounce_pos.x/2.0, bounce_pos.y/2.0 + bounce_height)
	tween_node.interpolate_property(animated_sprite_node, 'position', current_position, jump_pos, time_frame/2.0, Tween.TRANS_QUAD, Tween.EASE_IN)
	# Go to ground.
	tween_node.interpolate_property(animated_sprite_node, 'position', jump_pos, bounce_pos, time_frame/2.0, Tween.TRANS_QUAD, Tween.EASE_OUT, time_frame/2.0)
	tween_node.start()