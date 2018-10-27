extends "res://UI/Scripts/Inheritables/ICooldown.gd"

func _ready():
	casting_node.connect("secondary_used", self, "animation_cooldown_start")