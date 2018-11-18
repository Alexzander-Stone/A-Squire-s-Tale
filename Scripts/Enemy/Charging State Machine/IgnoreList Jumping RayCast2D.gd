# Add exceptions to the various collision fields that are on the first layer.
# Needed so the raycast can hit the walls without
##
#OR
##
# Place the tilemap on two collision layers, one made specifically for the jumping raycast.
extends RayCast2D

export(Array, NodePath) var exception_paths

func _ready():
	for path in exception_paths:
		add_exception(get_node(path))