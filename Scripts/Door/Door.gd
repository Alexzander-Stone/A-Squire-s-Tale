extends StaticBody2D

func _ready():
   pass
   
func inititate_interaction():
   open_door()
   return false
   
func next_interaction():
   return false

func open_door():
   queue_free()