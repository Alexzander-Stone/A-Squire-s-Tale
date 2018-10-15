extends Position2D

# Used for setting references to parent after they have been created.
onready var parent = get_parent()

func _ready():
	update_pivot_angle()

func _process(delta):
	update_pivot_angle()

func update_pivot_angle():
	# Angle available to vectors
	rotation = parent.velocity.angle()