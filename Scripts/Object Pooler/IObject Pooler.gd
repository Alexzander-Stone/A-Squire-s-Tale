# Requires signal in objects for deactivation of each object.
# The root node of each object scene must contain this deactivation signal.
extends Node

# Object pooling for less creation of new resources.
var active_objects = []
var object_pool = []

# Node spawn_object(args)
# Return: Node of object from object pooler.
# args = list of arguments [object to spawn scene, signal name]
func spawn_object(args):
	print(object_pool.size())
	# Create a new node if object pool is empty.
	# Otherwise, reuse a node from the pool.
	if object_pool.size() <= 0:
		# Set path to class/node to be created. Then create the object.
		var object_to_spawn = args[0]
		var new_node = object_to_spawn.instance()
		# Signal to send into object pool once the node has finished it's goal.
		new_node.connect(args[1], self, "add_to_pool")
		# Add to the active list of objects
		active_objects.append(new_node)
		return new_node
	else:
		var pool_node = object_pool.pop_back()
		# Add to the active list of objects
		active_objects.append(pool_node)
		return pool_node

# Finished nodes will be placed into the object pool.
func add_to_pool(object_node):
	var index = active_objects.find(object_node)
	object_pool.append(active_objects[index])
	active_objects.remove(index)
	# Remove from node tree to prevent from running.
	remove_child(object_node)