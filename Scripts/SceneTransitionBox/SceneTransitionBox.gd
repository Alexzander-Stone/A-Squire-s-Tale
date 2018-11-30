extends Node2D

export (String) var to_scene
var update_interval = 0.5
var time_since_update = 0
var collision_node
var moved_to_scene = false

func _ready():
   # Called when the node is added to the scene for the first time.
   # Initialization here
   collision_node = get_node("Area2D")
   collision_node.connect("area_entered", self, "collision_detected")

func _process(delta):
   if not moved_to_scene: 
      time_since_update += delta
      if(time_since_update > update_interval):
         update_shader()
         time_since_update = 0

func collision_detected(colliding_object):
   if not moved_to_scene:
      moved_to_scene = true
      collision_node.disconnect("area_entered", self, "collision_detected")
      move_to_scene()

func update_shader():
   get_node("ColorRect").color = get_node("ColorRect").color.inverted()
   
func move_to_scene():
   var env = get_node("/root/World/Environment")
   env.load_new_level(to_scene)
