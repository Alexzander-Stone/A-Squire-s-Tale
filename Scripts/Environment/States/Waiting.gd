extends "res://Scripts/State Machine/State.gd"

var environment_node

func _ready():
   environment_node = get_node("/root/World/Environment")
   environment_node.connect("change_scene", self, "changeScenes")

# void toggleDeath
# Send player state to the dying state.
func changeScenes():
   print("Waiting: changed scenes")
   emit_signal("finished", "fading out", [])
