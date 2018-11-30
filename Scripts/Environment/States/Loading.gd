extends "res://Scripts/State Machine/State.gd"
   
func enter(args):
   print("Loading: enter")
   emit_signal("finished", "fading in", [])