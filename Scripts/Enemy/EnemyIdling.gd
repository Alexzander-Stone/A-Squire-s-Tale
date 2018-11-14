extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFollowable.gd"

export(float) var base_time_until_search
export(float) var search_variable_time
var to_search_timer

# When entering the idle state, sent up a timer that will 
# eventually send the enemy to a searching state.
# Timer will include a random value to provide variety to 
# search timer.
func enter(args):
	owner.velocity = Vector2(0,0)
	to_search_timer = base_time_until_search + rand_range(0, search_variable_time)
	# Check for Player to attack.
	if true:
		emit_signal("finished", "walking", [])
	.enter(args)


func update(delta):
	# Check for Player to attack.
	if true:
		emit_signal("finished", "walking", [])
	# Check for search call.
	if to_search_timer <= 0:
		emit_signal("finished", "searching", [])
	else:
		to_search_timer -= delta