extends TextureProgress

func _ready():
	var player_node = get_node("/root/World/Player")
	player_node.connect("damaged", self, "decrease_health")

func decrease_health(damage):
	value -= damage