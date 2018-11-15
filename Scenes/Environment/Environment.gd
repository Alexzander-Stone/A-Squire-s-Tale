extends Node2D

#States for changing scene
#0 means not changing scene, do nothing
#1 means started transition
#2 means deleting level
#3 means loading new level
#4 means finished
#should start back at 0
var changing_scene = 0
var to_level = ""

func _ready():

   pass
   
func _process(delta):
   if changing_scene > 0:
      process_change_scene()
      
func process_change_scene():
   if changing_scene == 1:
      screen_transition()
      changing_scene += 1
   elif changing_scene == 2:
      delete_cur_level()
      changing_scene += 1
   elif changing_scene == 3:
      load_new_level()
      changing_scene += 1
   else:
      changing_scene = 0

func screen_transition():
   pass
   
func delete_cur_level():
   self.remove_child(get_node("Level"))
   
func load_new_level():
   var scene = load(to_level)
   var scene_instance = scene.instance()
   scene_instance.set_name("Level")
   add_child(scene_instance)
   
   var start_node = get_node("Level/Player_Start_Loc")
   var start_loc = start_node.get_position()
   var player_node = get_node("/root/World/Player")
   player_node.set_position(start_loc)

func change_levels_notification(var to_scene):
   to_level = to_scene
   changing_scene = 1
   

   

