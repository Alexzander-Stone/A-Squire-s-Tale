extends Node2D

#States for changing scene
#0 means not changing scene, do nothing
#1 means fade out
#2 means deleting level
#3 means loading new level
#4 means fade in
#5 means finished
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
      fade_out()
      changing_scene += 1
   elif changing_scene == 2:
      delete_cur_level()
      changing_scene += 1
   elif changing_scene == 3:
      load_new_level()
      changing_scene += 1
   elif changing_scene == 4:
      fade_in()
      changing_scene += 1
   else:
      changing_scene = 0

func fade_out():
   var ts = get_node("TransitionScreen")
   ts.show()
   get_node("Tween").interpolate_property(ts, "modulate", Color(255, 255, 255, 255), Color(0, 0, 0, 0), 10, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   
   var t = Timer.new()
   t.set_wait_time(10)
   t.set_one_shot(true)
   self.add_child(t)
   t.start()
   yield(t, "timeout")
   t.queue_free()
   
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

func fade_in():
   var ts = get_node("TransitionScreen")
   ts.show()
   get_node("Tween").interpolate_property(ts, "modulate", Color(0, 0, 0, 0), Color(255, 255, 255, 255), 10, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   

func change_levels_notification(var to_scene):
   to_level = to_scene
   changing_scene = 1
   

   

