extends "res://Scripts/UI/Inheritables/ICooldown.gd"

func _ready():
	ability_node.connect("begin_super_cooldown", self, "animation_cooldown_start")