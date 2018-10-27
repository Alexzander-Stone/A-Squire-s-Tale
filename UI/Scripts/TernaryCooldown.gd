extends "res://UI/Scripts/Inheritables/ICooldown.gd"

func _ready():
	casting_node.connect("ternary_used", self, "animation_cooldown_start")