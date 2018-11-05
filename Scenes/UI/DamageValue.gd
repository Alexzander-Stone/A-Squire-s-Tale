extends Node2D

signal goal_completed()

func _ready():
	get_node("Damage Value/Tween").connect("tween_completed", self, "signal_end")

func signal_end(object, path):
	emit_signal("goal_completed", self)