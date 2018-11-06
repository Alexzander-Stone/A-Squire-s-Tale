extends Control

#container holding the list of dialogs
#   you should be able to fill the dialog list in the
#   inspector script variables.
export(Array) var dialog_list = array()
#current dialog from the dialog_list
var index = 0
#bool for if the popup is currently active
var active = false

func _ready():

   pass

func _process(delta):
   if active and Input.is_action_just_pressed("interact"):
      var fin = next()
      if fin == -1: 
         finish()  
   
func next():
   if index < dialog_list.size() - 1:
      index = index + 1
      get_node("Text").text = dialog_list[index]
      if index+1 < dialog_list.size() - 1:
         get_node("Next Arrow").visible = false
      return index
   else:
      return -1

func reset_dialog():
   index = 0

func start(): 
   active = true
   visible = true
   get_node("Background").visible = true
   get_node("Text").text = dialog_list[index]
   get_node("Text").visible = true
   get_node("Next Arrow").visible = true

func finish():
   active - false
   visible = false
   reset_dialog()
   get_node("Background").visible = false
   get_node("Text").text = ""
   get_node("Text").visible = false
   get_node("Next Arrow").visible = false
   