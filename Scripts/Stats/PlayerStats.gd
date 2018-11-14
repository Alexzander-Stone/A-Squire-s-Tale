extends "res://Scripts/Stats/BasicStats.gd"

#List of artifacts
var artifactList = []

#dictionary of all artifacts
var artifacts_dict = {}
#stats specific to player
#export(int) var runSpeed = 10
export(float) var cdr = 0.0

#modified stats (for trinket changes)
var mMaxHealth = 150
#onready var mWalkSpeed = walkSpeed
#onready var mRunSpeed = runSpeed
var mcdr = 0.0

func _ready():
	
	var file = File.new()
	file.open("res://Assets/JSON/Artifacts/Artifacts.json", File.READ)
	var text_data = file.get_as_text()
	file.close()
	
	artifacts_dict = parse_json(text_data)
	
	mMaxHealth = maxHealth + 50
	mcdr = cdr
	
func addArtifact(args):
	artifactList.append(args[0])
	updateStats()
#placed this here for consistency of signals being sent to the GUI
func heal(restore):
	currentHealth += restore
	if(currentHealth > mMaxHealth):
		currentHealth = mMaxHealth


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

