extends Node


# generic stats for all enemies
var maxHealth = 100
var currentHealth = maxHealth
var walkSpeed = 5
var runSpeed = 10
var damage = 10
var attackSpeed = 1.0


#stats specific to player

#resource bar variable, may not need it for prototype
var resource = 0
var cdr = 1.0
var experience = 0
var level = 1
var gold = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
