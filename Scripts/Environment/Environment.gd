extends Node2D

signal change_scene(to_scene)

var to_level = ""
export (String) var starting_level
var is_fading = false

export (NodePath) var transition_screen_path
onready var transition_screen_node = get_node(transition_screen_path)

export (NodePath) var player_path
onready var player_node = get_node(player_path)

export (NodePath) var tween_path
onready var tween_node = get_node(tween_path)

func _ready():
   change_levels_notification(starting_level)   
   load_new_level()

func toggle_fade():
   transition_screen_node.show()
   if is_fading == false:
      tween_node.interpolate_property(transition_screen_node, "modulate", Color(0, 0, 0, 0), Color(255, 255, 255, 255), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   elif is_fading == true:
      tween_node.interpolate_property(transition_screen_node, "modulate", Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT )
   tween_node.start()
   is_fading = !is_fading
   
func delete_cur_level():
   get_node("Level").queue_free()
   remove_child(get_node("Level"))
   
func load_new_level():
   var scene = load(to_level)

   var scene_instance = scene.instance()
   scene_instance.set_name("Level")
   add_child(scene_instance)
   
   var start_node = get_node("Level/Player_Start_Loc")
   var start_loc = start_node.get_position()
   player_node.set_position(start_loc)

func change_levels_notification(var to_scene):
   to_level = to_scene
   emit_signal("change_scene")
   
func reset():
   #transition_screen_node.hide()
   pass
