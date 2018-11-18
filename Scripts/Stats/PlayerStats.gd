extends "res://Scripts/Stats/BasicStats.gd"

#List of artifacts
var artifactList = []

#list of all current statuses
var currentStatusEffects= []

#dictionary of all artifacts
var artifacts_dict = {}

#dictionary of all status effects
var status_effects_dict = {}


#stats specific to player
#export(int) var runSpeed = 10
export(float) var cdr = 0.0
export(float) var damageMod = 1.0

#modified stats (for trinket changes)
var mMaxHealth = 150
var mWalkSpeed
var mRunSpeed
var mcdr = 0.0
var mDamageMod= 1.0

func _ready():
	
	var file = File.new()
	file.open("res://Assets/JSON/Artifacts/Artifacts.json", File.READ)
	var text_data = file.get_as_text()
	file.close()
	
	artifacts_dict = parse_json(text_data)
	
	file = File.new()
	file.open("res://Assets/JSON/Status Effects/Status Effects.json", File.READ)
	text_data = file.get_as_text()
	file.close()
	
	status_effects_dict = parse_json(text_data)
	
	mWalkSpeed = walkSpeed
	mRunSpeed = runSpeed
	mMaxHealth = maxHealth + 50
	mcdr = cdr
	mDamageMod = damageMod
	
func addArtifact(args):
	artifactList.append(args[0])
	updateStats()
#placed this here for consistency of signals being sent to the GUI
func heal(restore):
	currentHealth += restore
	if(currentHealth > mMaxHealth):
		currentHealth = mMaxHealth

func _process(delta):
	#add all of the status effect stats to the modified stats
	#for artifact in artifactList:
	#mcdr = cdr + artifacts_dict[artifact]["cdrMod"]
	#when timer is done for each one, remove it and the stat modifiers
	pass
func updateStats():
	#add every available artifact stat to the modified stats
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

