extends "res://Scripts/State Machine/State.gd"

var tween_node
var environment_node

func _ready():
   tween_node = get_node("/root/World/Environment/TweenIn")
   tween_node.connect("tween_completed", self, "on_tween_finished_fade_in")
   environment_node = get_node("/root/World/Environment")
   
func enter(args):
   print("Fadingin: enter")
   environment_node.fade_in()
   
func on_tween_finished_fade_in(x, y):
   print("Fadingin: changed scenes")
   emit_signal("finished", "waiting", [])