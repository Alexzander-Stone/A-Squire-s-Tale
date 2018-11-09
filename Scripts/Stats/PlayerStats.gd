extends "res://Scripts/Stats/BasicStats.gd"

#List of artifacts

#stats specific to player
export(int) var runSpeed = 10
export(float) var cdr = 1.0

#modified stats (for trinket changes
var mMaxHealth = 100
var mWalkSpeed = 5
var mRunSpeed = 5


#export(int) var experience = 0
#export(int) var level = 1
#export(int) var gold = 0
#resource bar variables, may not need it for prototype
#export(int) var maxResource = 100
#export(int) var currentResource = 0

#updateStats() function called when player gets a new trinket(signal), updates modified stats

