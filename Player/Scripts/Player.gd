extends Node2D

var velocity = Vector2(0,0)
var MAX_VELOCITY = 5

func _ready():
	print("created")

func _process(delta):
	print(velocity)

func update_position():
	# Max velocity speed. Need to replace b/c diagonal stuff.
	if(velocity.x > MAX_VELOCITY):
		velocity.x = MAX_VELOCITY
	if(velocity.y > MAX_VELOCITY):
		velocity.y = MAX_VELOCITY
		
	if(velocity.x < -MAX_VELOCITY):
		velocity.x = -MAX_VELOCITY
	if(velocity.y < -MAX_VELOCITY):
		velocity.y = -MAX_VELOCITY
	
	position += velocity