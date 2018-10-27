extends "res://UI/Scripts/Inheritables/ICooldown.gd"

func _ready():
	casting_node.connect("super_used", self, "animation_cooldown_start")