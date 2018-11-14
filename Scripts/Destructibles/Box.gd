extends Node


export(int) var health = 3

export(NodePath) var collision_path 
var collision_node

func _ready():
	collision_node = get_node(collision_path)
	collision_node.connect("area_entered", self, "collisionDetected")
	
func collisionDetected(colliding_object):
	health -= 1
	#emit_signal("medkit_acquired", [healthRestore])
	#queue for deletion at the end of the frame
	if(health == 0):
		queue_free()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
