extends Node

export(NodePath) var parent_path
export(NodePath) var animated_sprite_path

onready var parent_node = get_node(parent_path)
onready var animated_sprite_node = get_node(animated_sprite_path)
onready var tween_node = $"Tween"
onready var damage_label_node = $"Damage Label"

var texture_height
var texture_width

func _ready():
	parent_node.connect("damaged", self, "emit_damage")
	
	texture_height = animated_sprite_node.frames.get_frame(animated_sprite_node.animation, 0).get_height()
	texture_width = animated_sprite_node.frames.get_frame(animated_sprite_node.animation, 0).get_width()

func emit_damage(damageValue):
	# Reset position/modulation.
	reset_tween_settings()
	# Update text of visual to represent damage taken.
	damage_label_node.clear()
	damage_label_node.add_text(str(damageValue))
	# Determine animation for label. Find random location to go towards.
	var newX = randi()%81 if randi() % 2 == 0 else -randi()%81
	var newY = randi()%81 if randi() % 2 == 0 else -randi()%81
	var goto = get_position() + Vector2(newX, newY)
	tween_node.interpolate_property(self, 'rect_position', get_position(), goto, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.interpolate_property(self, 'modulate', get_modulate(), Color("00ffffff"), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.start()

func reset_tween_settings():
	set_position(animated_sprite_node.get_position() + Vector2(texture_width/4, -texture_height/2))
	set_modulate(Color("ffffff"))