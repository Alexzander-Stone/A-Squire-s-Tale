extends TextureProgress

func _ready():
	var damaged_state = get_node("/root/World/Player/StateMachine/Flinching")
	damaged_state.connect("damaged", self, "decrease_health")

func decrease_health(damage):
	print("hello")