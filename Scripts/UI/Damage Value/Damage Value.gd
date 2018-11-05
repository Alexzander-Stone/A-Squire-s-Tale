extends Node

# When the node has finished with it's tween animation, send the root 
# to the spawner. This will be compared to the active damage value gui
# to determine which node will be sent to the object pool.

onready var tween_node = $"Tween"
onready var damage_label_node = $"Damage Label"

func emit_damage(damageValue, GUI_position, GUI_start_color, GUI_end_color):
	# Reset position/modulation.
	reset_tween_settings(GUI_position, GUI_start_color)
	# Update text of visual to represent damage taken.
	damage_label_node.clear()
	damage_label_node.add_text(str(damageValue))
	# Determine animation for label. Find random location to go towards.
	var newX = randi()%81 if randi() % 2 == 0 else -randi()%81
	var newY = randi()%81 if randi() % 2 == 0 else -randi()%81
	var goto = get_position() + Vector2(newX, newY)
	tween_node.interpolate_property(self, 'rect_position', get_position(), goto, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.interpolate_property(self, 'modulate', get_modulate(), GUI_end_color, 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween_node.start()

func reset_tween_settings(GUI_position, GUI_start_color):
	set_position(GUI_position)
	set_modulate(GUI_start_color)