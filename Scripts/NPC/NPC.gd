extends KinematicBody2D

export(NodePath) var dialog_box_path
var dialog_box_node

var is_talking = false
var direction_vector = Vector2(0,0)

func _ready():
   get_node("AnimationPlayer").play("facing_down")
   dialog_box_node = get_node(dialog_box_path)

#TODO: Place into an inheritable script
func inititate_interaction():
	print("Hi hooman. Whalecome.")
	dialog_box_node.start()
	return true

func next_interaction():
	dialog_box_node.next()
	return dialog_box_node.active
#TODO: Place into an inheritable script.