extends KinematicBody2D

func _ready():
   
   pass

func _process(delta):
   
   pass

func interact():
   print("Hi human. Welcome.")
   
func open_dialog():
   get_node("Dialog_box").start()
   pass