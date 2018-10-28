extends Area2D

func _process(delta):
	if(get_overlapping_areas() != []):
		emit_signal("area_entered")
