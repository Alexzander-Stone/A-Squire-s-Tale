extends "res://Scripts/Abilities/Inheritables/IAnimatedWeapon.gd"

signal giveStatus

export(String) var statusEffect = "Warcry"

func _ready():
	#for now, warcry works to give all players a movespeed and damage boost
	for p in get_tree().get_nodes_in_group("player"):
		self.connect("giveStatus", p, "addStatusEffect")

func _process(delta):
	if !$"AnimationPlayer".is_playing():
		emit_signal("giveStatus", statusEffect)
	# Inheritable parent takes care of deletion of node.
	._process(delta)