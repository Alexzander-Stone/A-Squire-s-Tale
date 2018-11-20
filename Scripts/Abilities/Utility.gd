extends "res://Scripts/Abilities/Inheritables/IAnimatedWeapon.gd"

signal tickDamage

#base values, edit later
var tickTimer = 1.0
var currentTick = 1.0

func _ready():
	self.connect("area_entered", self, "ObjectEntered")
	self.connect("area_exited", self, "ObjectExited")

func ObjectEntered(colliding_object):
	#this routes by the flinching state, so enemies take damage but don't flinch
	self.connect("tickDamage", colliding_object.owner, "take_damage")

func ObjectExited(colliding_object):
	if(colliding_object.owner != null):
		self.disconnect("tickDamage", colliding_object.owner, "take_damage")

func _process(delta):
	# Inherited parent takes care of removal of node.
	._process(delta)
	if(currentTick >= 0):
		currentTick -= delta
	else:
		emit_signal("tickDamage", calculate_damage())
		currentTick = tickTimer