extends Node2D

signal change_scene(to_scene)

var to_level = ""
var transition_screen_node

func _ready():
   transition_screen_node = get_node("/root/World/CanvasLayer/GUI/TransitionScreen")
   pass

func fade_out():
   var ts = transition_screen_node
   ts.show()
   get_node("TweenOut").interpolate_property(ts, "modulate", Color(0, 0, 0, 0), Color(255, 255, 255, 255), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   get_node("TweenOut").start()
   
func delete_cur_level():
   get_node("Level").queue_free()
   
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
   var ts = transition_screen_node
   ts.show()
   get_node("TweenIn").interpolate_property(ts, "modulate", Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   get_node("TweenIn").start()

func change_levels_notification(var to_scene):
   to_level = to_scene
   emit_signal("change_scene")
   
func reset():
   #transition_screen_node.hide()
   pass
