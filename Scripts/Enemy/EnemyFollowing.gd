# If we want to remove the slow approach to the player, we can create a variable
# that is assigned upon entering for the direction to move.

extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

export(NodePath) var vision_path
onready var vision_node = get_node(vision_path)

export(NodePath) var attack_begin_collision_path
onready var attack_begin_collision_node = get_node(attack_begin_collision_path)

export(float) var max_velocity_magnitude = 100
export(float) var speed_multiplier = 1

var velocity = Vector2(0,0)
var perceived_player_position = Vector2(0,0)
var player_to_follow = null

# void enter
# args[0], contains the player object for when the player entered the vision cone.
func enter(args):
	begin_following(args[0])
	attack_begin_collision_node.connect("area_entered", self, "begin_charging")
	.enter(args)

func exit():
	attack_begin_collision_node.disconnect("area_entered", self, "begin_charging")
	.exit()

func update(delta):
	# Update perceived player's coordinates when player has left the 
	# vision cone or the enemy has reached the coordinates.
	
	##
	#Replace with charging hitbox check and transition to charging.
	##
	if ( 
		owner.position.x <= perceived_player_position.x + 10 && owner.position.y <= perceived_player_position.y + 10
		&& owner.position.x >= perceived_player_position.x - 10 && owner.position.y >= perceived_player_position.y - 10
		):
		# Update player coordinates.
		# Begin moving towards new coordinates.
		#owner.move_and_slide(perceived_player_position)
		emit_signal("finished", "searching", [])
	else:
		owner.move_and_slide(velocity)
	
	# Update the rotation of the vision cone to "follow" player.
	# This value will be constantly updated, unlike the player movement. Helps with vision tracking.
	var vision_direction = (player_to_follow.position - owner.position).normalized()
	# Changes godot angle to trig angle.
	var vision_angle = rad2deg(vision_direction.angle()) - 90
	vision_node.rotation_degrees = vision_angle

func begin_following(player_object):
	# Keep track of player for movement updates.
	player_to_follow = player_object
	
	# Record player's current coordinates upon entering.
	perceived_player_position = player_to_follow.position
	
	# Set up the enemy's velocity.
	velocity = calculate_velocity_based_on(perceived_player_position)
	
	owner.move_and_slide(velocity)

func begin_charging(collided_object):
	if collided_object.owner == player_to_follow:
		emit_signal("finished", "charging", [player_to_follow.position])

func calculate_velocity_based_on(object_position):
	return (object_position - owner.position).clamped(max_velocity_magnitude) * speed_multiplier