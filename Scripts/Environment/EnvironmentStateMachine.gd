extends "res://Scripts/State Machine/IStateMachine.gd"

#0 not changing scene, do nothing
#1 fade out
#2 deleting level
#3 loading new level
#4 fade in
#5 finished
func _ready():
   states_map = {
   "waiting": $Waiting,
   "fading out": $"Fading Out",
   "deleting": $Deleting,
   "loading": $Loading,
   "fading in": $"Fading In"
   }