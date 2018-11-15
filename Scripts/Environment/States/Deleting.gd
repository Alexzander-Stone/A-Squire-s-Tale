extends "res://Scripts/State Machine/State.gd"

var environment_node

func _ready():
   environment_node = get_node("/root/World/Environment")
   
func enter(args):
   print("Deleting: enter")
   environment_node.delete_cur_level()
   finish()
   
func finish():
   print("Deleting: changed scenes")
   emit_signal("finished", "loading", []);