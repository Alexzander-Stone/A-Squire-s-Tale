extends TextureProgress


func _ready():
	var player_node = get_node("/root/World/Player")
	#needed to readjust the max healthbar length, if we add anything that changes max health,
	#make a new signal and call it from the stats node. This code will add a new function to change the max_value
	var player_stats_node = get_node("/root/World/Player/Stats")
	max_value =  player_stats_node.mMaxHealth
	
	player_node.connect("damaged", self, "decrease_health")
	player_node.connect("healed", self, "increase_health")



func decrease_health(damage):
	value -= damage

func increase_health(restore):
	print(restore)
	value += restore