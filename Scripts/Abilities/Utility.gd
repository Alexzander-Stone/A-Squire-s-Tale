extends Area2D

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "ObjectEntered")
	collision_node.connect("area_exited", self, "ObjectExited")

func ObjectEntered(colliding_object):
	pass
	
func ObjectExited(colliding_object):
	pass
	

func _process(delta):
	if !$"AnimationPlayer".is_playing():
		queue_free()

func play_animation(animation_to_play):
	$"AnimationPlayer".play(animation_to_play)

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return default_damage