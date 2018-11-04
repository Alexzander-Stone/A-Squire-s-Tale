extends TextureProgress

var ability_node
var cooldown_timer = 0

func _ready():
	ability_node = $"/root/World/Player/Abilities"

func animation_cooldown_start(time):
	cooldown_timer = time
	set_value(cooldown_timer)
	set_max(cooldown_timer)

func _process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
		set_value(cooldown_timer)