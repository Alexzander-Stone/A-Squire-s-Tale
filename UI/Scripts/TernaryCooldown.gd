extends "res://UI/Scripts/Inheritables/ICooldown.gd"

func _ready():
	ability_node.connect("begin_ternary_cooldown", self, "animation_cooldown_start")