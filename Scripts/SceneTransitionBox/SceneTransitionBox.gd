extends Node2D

export (String) var to_scene
var update_interval = 0.5
var time_since_update = 0
var transitioning = false
var collision_node

func _ready():
   # Called when the node is added to the scene for the first time.
   # Initialization here
   collision_node = get_node("Area2D")
   collision_node.connect("area_entered", self, "collision_detected")

func _process(delta):
   time_since_update += delta
   if(time_since_update > update_interval):
      if(transitioning):
         scene_transition_animation()
      else:
         update_shader()
      time_since_update = 0
   

func collision_detected(colliding_object):
   print("CONTACT REACHED")
   move_to_scene()

func update_shader():
   get_node("ColorRect").color = get_node("ColorRect").color.inverted()
   
func move_to_scene():
   transitioning = true
   get_node("ColorRect").color = Color(0, 0, 0, 0)
   scene_transition_animation()
   pass
   
func scene_transition_animation():
   var cur_shader = get_node("ColorRect").color
   print(cur_shader.a)
   if(cur_shader.a >= 250):
      get_tree().change_scene(to_scene)
   else:
      var r = cur_shader.r + 50
      var g = cur_shader.g + 50
      var b = cur_shader.b + 50
      var a = cur_shader.a + 50
      get_node("ColorRect").color = Color(r, g, b, a)

