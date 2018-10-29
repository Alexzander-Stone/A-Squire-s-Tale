extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var cur = ""

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _process(delta):
	pass

func play():
	if(cur != ""):
		get_node(cur).play()
	else:
		print("No sfx selected.")

func stop():
	if(cur != ""):
		get_node(cur).stop()
	else:
		print("No song selected.")

func play_sfx(var sfx):
	if(cur != ""):
		stop()
	cur = sfx
	play()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
