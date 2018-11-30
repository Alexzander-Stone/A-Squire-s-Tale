extends "res://Scripts/State Machine/State.gd"

export (NodePath) var tween_path
onready var tween_node = get_node(tween_path)

export(NodePath) var environment_path
onready var environment_node = get_node(environment_path)
   
func enter(args):
   tween_node.connect("tween_completed", self, "on_tween_finished_fade_in")
   print("Fadingin: enter")
   environment_node.toggle_fade()

func exit():
   tween_node.disconnect("tween_completed", self, "on_tween_finished_fade_in")
   
func on_tween_finished_fade_in(node, node_path):
   print("Fadingin: changed scenes")
   emit_signal("finished", "waiting", [])