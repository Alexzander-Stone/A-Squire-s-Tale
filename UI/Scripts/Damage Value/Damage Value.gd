extends Node

var tween_node
var label_node 
var dummy_collision_node
var parent_node

var texture_height
var texture_width

func _ready():
	parent_node = $"../Full Sprite/AnimatedSprite"
	dummy_collision_node = $"../Full Sprite/AnimatedSprite/Area2D"
	dummy_collision_node.connect("area_entered", self, "emit_damage")
	tween_node = $"Tween"
	label_node = $"RichTextLabel"
	
	texture_height = parent_node.frames.get_frame(parent_node.animation, 0).get_height()
	texture_width = parent_node.frames.get_frame(parent_node.animation, 0).get_width()

func emit_damage(damageValue):
	damageValue=40
	# Reset position/modulation.
	reset_tween_settings()
	# Update text of visual to represent damage taken.
	label_node.clear()
	label_node.add_text(str(damageValue))
	var goto = get_position() + Vector2(randi()%81 - 40,randi()%81 - 40)
	tween_node.interpolate_property(self, 'rect_position', get_position(), goto, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.interpolate_property(self, 'modulate', get_modulate(), Color("00ffffff"), 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.start()

func reset_tween_settings():
	set_position(parent_node.get_position() + Vector2(texture_width/4, -texture_height/2))
	set_modulate(Color("ffffff"))