extends "res://Scripts/Stats/BasicStats.gd"

#List of artifacts
var artifactList = []

#list of all current statuses
var CurrentStatusEffects= []

var StatusEffectDurations = []

#dictionary of all artifacts
var artifacts_dict = {}

#dictionary of all status effects
var status_effects_dict = {}


#stats specific to player
#export(int) var runSpeed = 10
export(float) var cdr = 0.0
export(float) var damage = 1.0
#stat modifiers

var maxHealthMod = 0
var speedMod = 0
var cdrMod = 0
var damageMod = 0.0

#modified stats (used by outside functions)
var mMaxHealth = 100
var mWalkSpeed
var mRunSpeed
var mcdr = 0.0
var mDamage = 1.0

func _ready():
	
	#get artifact dictionary
	var file = File.new()
	file.open("res://Assets/JSON/Artifacts/Artifacts.json", File.READ)
	var text_data = file.get_as_text()
	file.close()
	
	artifacts_dict = parse_json(text_data)
	
	#get status effect dictionary
	file = File.new()
	file.open("res://Assets/JSON/Status Effects/Status Effects.json", File.READ)
	text_data = file.get_as_text()
	file.close()
	
	status_effects_dict = parse_json(text_data)
	
	#set base values for stats
	
	mWalkSpeed = walkSpeed
	mRunSpeed = runSpeed
	mMaxHealth = maxHealth
	mcdr = cdr
	mDamage = damage
	
	#addStatus("Warcry")

#placed this here for consistency of signals being sent to the GUI
func heal(restore):
	currentHealth += restore
	if(currentHealth > mMaxHealth):
		currentHealth = mMaxHealth

func addArtifact(args):
	artifactList.append(args[0])
	calculateArtifactModifiers()
	updateStats()
	

func addStatus(status):
	if(!CurrentStatusEffects.has(status)):
		CurrentStatusEffects.append(status)
		StatusEffectDurations.append(status_effects_dict[status]["duration"])
		addStatusModifier(status)
		#update stats to reflect the change in status
		updateStats()
	else:
		StatusEffectDurations[CurrentStatusEffects.find(status)] = status_effects_dict[status]["duration"]
	

func _process(delta):
	
	#count down status effect timers sequentially, and remove them when they hit zero
	for i in range(StatusEffectDurations.size()):
		StatusEffectDurations[i] -= delta
		#if this is true, remove the status effect
		if(StatusEffectDurations[i] <= 0):
			removeStatusModifier(CurrentStatusEffects[i])
			CurrentStatusEffects.remove(i)
			StatusEffectDurations.remove(i)
			#update stats to reflect the change in status
			updateStats()

func updateStats():
	mcdr =  cdr + cdrMod
	mDamage = damage + damageMod
	mWalkSpeed = walkSpeed + speedMod
	mRunSpeed = runSpeed + speedMod*2
	print(mWalkSpeed)
	
	
func calculateArtifactModifiers():
	#add every available artifact stat to the modified stats
	#temp value must change to incorporate a STATUSCDRMOD
	cdrMod = 0
	for artifact in artifactList:
		cdrMod +=  artifacts_dict[artifact]["cdrMod"]
		
		
func addStatusModifier(status):
	#add individual status when it is gained
		damageMod += status_effects_dict[status]["damageMod"]
		speedMod += status_effects_dict[status]["speedMod"]
		
func removeStatusModifier(status):
	#remove individual status when it is lost
		damageMod -= status_effects_dict[status]["damageMod"]
		speedMod -= status_effects_dict[status]["speedMod"]

#export(int) var experience = 0
#export(int) var level = 1
#export(int) var gold = 0
#resource bar variables, may not need it for prototype
#export(int) var maxResource = 100
#export(int) var currentResource = 0


