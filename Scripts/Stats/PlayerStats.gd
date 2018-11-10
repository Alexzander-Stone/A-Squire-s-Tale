extends "res://Scripts/Stats/BasicStats.gd"

#List of artifacts
var artifactList = []

#dictionary of all artifacts
var artifacts_dict = {}
#stats specific to player
#export(int) var runSpeed = 10
export(float) var cdr = 0.0

#modified stats (for trinket changes)
onready var mMaxHealth = maxHealth
#onready var mWalkSpeed = walkSpeed
#onready var mRunSpeed = runSpeed
onready var mcdr = cdr

func _ready():
	var file = File.new()
	file.open("res://Assets/JSON/Artifacts/Artifacts.json", File.READ)
	var text_data = file.get_as_text()
	file.close()
	
	artifacts_dict = parse_json(text_data)
	artifactList.append("Stopwatch")
	updateStats()
	
func updateStats():
	for artifact in artifactList:
		mcdr = cdr + artifacts_dict[artifact]["cdrMod"]

#export(int) var experience = 0
#export(int) var level = 1
#export(int) var gold = 0
#resource bar variables, may not need it for prototype
#export(int) var maxResource = 100
#export(int) var currentResource = 0

#updateStats() function called by 
#newArtifact(string artifact_name) which is called when player gets a new trinket(signal), updates modified stats

