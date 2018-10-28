extends Node

var cur = ""

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	cur = ""
	play_song("opening")
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("play_music_1"):
		if(cur == "dungeon"):
			if(get_node(cur).playing):
				stop()
			else:
				play()
		else:
			play_song("dungeon")
	elif Input.is_action_just_pressed("play_music_2"):
		if(cur == "town"):
			if(get_node(cur).playing):
				stop()
			else:
				play()
		else:
			play_song("town")
	elif Input.is_action_just_pressed("play_music_3"):
		if(cur == "boss"):
			if(get_node(cur).playing):
				stop()
			else:
				play()
		else:
			play_song("boss")
	elif Input.is_action_just_pressed("play_music_4"):
		if(cur == "opening"):
			if(get_node(cur).playing):
				stop()
			else:
				play()
		else:
			play_song("opening")

func play():
	if(cur != ""):
		get_node(cur).play()
	else:
		print("No song selected.")

func stop():
	if(cur != ""):
		get_node(cur).stop()
	else:
		print("No song selected.")

func play_song(var song):
	if(cur == song):
		print("already playing.")
	else:
		if(cur != ""):
			stop()
		cur = song
		play()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
