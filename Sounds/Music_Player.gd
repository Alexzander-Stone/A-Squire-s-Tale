extends Node

var current_song = ""

func _ready():
	play_song("boss")

func _process(delta):
	if Input.is_action_just_pressed("play_music_1"):
		play_song("dungeon") if(current_song != "dungeon") else stop()
	elif Input.is_action_just_pressed("play_music_2"):
		play_song("town") if(current_song != "town") else stop()
	elif Input.is_action_just_pressed("play_music_3"):
		play_song("boss") if(current_song != "boss") else stop()
	elif Input.is_action_just_pressed("play_music_4"):
		play_song("opening") if(current_song != "opening") else stop()

func play():
	if(current_song != ""):
		get_node(current_song).play()
	else:
		print("No song selected.")

func stop():
	if(current_song != ""):
		get_node(current_song).stop()
	else:
		print("No song selected.")

func play_song(var song):
	if(current_song == song):
		print("already playing.")
	else:
		if(current_song != ""):
			stop()
		current_song = song
		play()