extends "res://Scripts/Object Pooler/IObject Pooler.gd"

export(NodePath) var animated_sprite_path
export(Color) var GUI_start_color = Color("ffffff")
export(Color) var GUI_end_color = Color("00ffffff")

onready var damage_GUI_spawner = preload("res://Scenes/UI/DamageValue.tscn")

onready var animated_sprite_node = get_node(animated_sprite_path)
onready var texture_height = animated_sprite_node.frames.get_frame(animated_sprite_node.animation, 0).get_height()
onready var texture_width = animated_sprite_node.frames.get_frame(animated_sprite_node.animation, 0).get_width()

func _ready():
	get_parent().connect("damaged", self, "spawn_damage_value")

func spawn_damage_value(damageValue):
	var new_node = spawn_object(["res://Scenes/UI/DamageValue.tscn", "goal_completed"])
	add_child(new_node)
	#Call after spawn.
	setup_damage_GUI(new_node, damageValue)

func setup_damage_GUI(damage_GUI_node, damageValue):
	var GUI_position = animated_sprite_node.get_position() + Vector2(texture_width/4, -texture_height/2)
	damage_GUI_node.get_node("Damage Value").emit_damage(damageValue, GUI_position, GUI_start_color, GUI_end_color)