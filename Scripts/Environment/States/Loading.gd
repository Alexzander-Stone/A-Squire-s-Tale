extends "res://Scripts/State Machine/State.gd"

var environment_node

func _ready():
   environment_node = get_node("/root/World/Environment")
   
func enter(args):
   print("Loading: enter")
   environment_node.load_new_level()
   finish()
   
func finish():
   print("Loading: changed scenes")
   emit_signal("finished", "fadingin", []);