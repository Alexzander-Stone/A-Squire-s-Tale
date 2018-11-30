extends "res://Scripts/State Machine/State.gd"

var tween_node
var environment_node

func _ready():
   tween_node = get_node("/root/World/Environment/Tween")
   tween_node.connect("tween_completed", self, "on_tween_finished_fade_out")
   environment_node = get_node("/root/World/Environment")
   
func enter(args):
   print("FadingOut: enter")
   environment_node.toggle_fade()
   
func on_tween_finished_fade_out(x, y):
   print("FadingOut: changed scenes")
   emit_signal("finished", "deleting", [])

