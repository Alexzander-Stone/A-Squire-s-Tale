extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gd"

var perceived_player_position = Vector2(0,0)

# void enter
# args[0], contains the player coordinates for when the player entered the vision cone.
func enter(args):
	begin_following(args[0])

func update(delta):
	# Update perceived player's coordinates when player has left the 
	# vision cone or the enemy has reached the coordinates.
	if ( 
		owner.position.x <= perceived_player_position.x + 100 && owner.position.y <= perceived_player_position.y + 100
		&& owner.position.x >= perceived_player_position.x - 100 && owner.position.y >= perceived_player_position.y - 100
		):
		print("hello")
		# Update player coordinates.
		# Begin moving towards new coordinates.
		#owner.move_and_slide(perceived_player_position)
		emit_signal("finished", "searching", [])
	else:
		owner.move_and_slide(perceived_player_position - owner.position)

func begin_following(player_position):
	# Record player's current coordinates upon entering.
	perceived_player_position = player_position
	print(perceived_player_position)
	owner.move_and_slide(perceived_player_position - owner.position)