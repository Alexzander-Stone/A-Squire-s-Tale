extends TextureProgress

var cooldown_timer = 0
var timeToCooldown = 1

func _process(delta):
	if Input.is_action_pressed("ui_up") and cooldown_timer <= 0:
		cooldown_timer = timeToCooldown
	if cooldown_timer > 0:
		cooldown_timer -= delta
		set_value(cooldown_timer)