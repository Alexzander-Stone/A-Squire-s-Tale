extends Area2D

var default_damage = 10
#base values, edit later
var damageMod = 1.0
var tickTimer = 1.0
var currentTick = 1.0

signal tickDamage

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
	if !$"AnimationPlayer".is_playing():
		queue_free()
	else:
		if(currentTick <= 0):
			emit_signal("tickDamage", calculate_damage())
			currentTick = tickTimer
		else:
			currentTick -= delta

func play_animation(animation_to_play):
	$"AnimationPlayer".play(animation_to_play)

# Allows the weapon to calculate what damage to return using the parent's stats.
func calculate_damage():
	return default_damage*damageMod