extends KinematicBody2D

var is_talking = false
var direction_vector = Vector2(0,0)

func _ready():
   get_node("AnimationPlayer").play("facing_down")
   pass

func _process(delta):
   if not is_talking and Input.is_action_just_pressed("interact"):
      interact()
      
   #basically if dialog is done
   if not get_node("Dialog_box").active and is_talking:
      ##
      #Potentially send a signal that dialog is done here
      ##
      is_talking = false
   pass

func interact():
   print("Hi human. Welcome.")
   is_talking = true
   open_dialog()
   
func open_dialog():
   get_node("Dialog_box").start()
   pass