extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (NodePath) var state_machine_path
var state_machine_node
var cur = ""

func _ready():
	print(state_machine_path)
	state_machine_node = get_node(state_machine_path)
	state_machine_node.connect("state_changed", self, "trigger_sfx_hit")

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

func play_sfx(sfx):
	if(cur != ""):
		stop()
	cur = sfx
	play()
	
func trigger_sfx_hit(state):
	
	if(state.name == "Flinching"):
		print("flinching sfx")
		var r = randi()
		if(r % 2):
			play_sfx("oh_no")
			print("hit sfx")
		else:
			play_sfx("hit")
			print("oh no sfx")


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
