extends "res://Scripts/State Machine/State.gd"

var environment_node

func _ready():
   environment_node = get_node("/root/World/Environment")
   environment_node.connect("change_scene", self, "changeScenes")

func handle_input(event):
   pass

func enter(args):
   print("Waiting: enter")
   environment_node.reset()

# void toggleDeath
# Send player state to the dying state.
func changeScenes():
   print("Waiting: changed scenes")
   emit_signal("finished", "fadingout", [])
