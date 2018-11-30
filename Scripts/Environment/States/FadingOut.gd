extends "res://Scripts/State Machine/State.gd"

export (NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(NodePath) var environment_path
onready var environment_node = get_node(environment_path)
   
func enter(args):
   tween_node.connect("tween_completed", self, "on_tween_finished_fade_out")
   print("FadingOut: enter")
   environment_node.toggle_fade()
   
func exit():
   tween_node.disconnect("tween_completed", self, "on_tween_finished_fade_out")

func on_tween_finished_fade_out(node, node_path):
   print("FadingOut: changed scenes")
   emit_signal("finished", "deleting", [])