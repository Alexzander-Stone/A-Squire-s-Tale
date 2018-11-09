extends Control

#container holding the list of dialogs
#   you should be able to fill the dialog list in the
#   inspector script variables.
export(Array) var dialog_list = Array()
#current dialog from the dialog_list
# !! Note: index is set to -1 because Input.is_action_just_pressed
#   Does not eat the input from when interact is pressed by player
#   thus the first dialog is immediately overwritten with next() call
#   starting at -1 is the current workaround and works fine
var index = -1
#bool for if the popup is currently active
var active = false

func _ready():
   reset_dialog()
   active = false
   pass
   
func next():
   if index < dialog_list.size() - 1:
      index = index + 1
      get_node("Text").text = dialog_list[index]
      if index + 1 >= dialog_list.size():
         get_node("Next Arrow").visible = false
      return index
   else:
      finish()

func reset_dialog():
   index = -1

func start(): 
   active = true
   visible = true
   get_node("Background").visible = true
   get_node("Text").text = ""
   get_node("Text").visible = true
   get_node("Next Arrow").visible = true
   next()

func finish():
   active = false
   visible = false
   reset_dialog()
   get_node("Background").visible = false
   get_node("Text").visible = false
   get_node("Next Arrow").visible = false
   