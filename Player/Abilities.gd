extends Node

# Signals inform gui to update cooldown indicators.
signal begin_primary_cooldown
signal begin_secondary_cooldown
signal begin_ternary_cooldown
signal begin_super_cooldown

export (int) var primary_cooldown
export (int) var secondary_cooldown
export (int) var ternary_cooldown
export (int) var super_cooldown

var primary_cooldown_timer = 0
var secondary_cooldown_timer = 0
var ternary_cooldown_timer = 0
var super_cooldown_timer = 0

var casting_node

func _ready():
	casting_node = $"../StateMachine/Casting"
	# Begin listening to casting node for cooldown directions.
	casting_node.connect("primary_used", self, "initialize_primary_cooldown")
	casting_node.connect("secondary_used", self, "initialize_secondary_cooldown")
	casting_node.connect("ternary_used", self, "initialize_ternary_cooldown")
	casting_node.connect("super_used", self, "initialize_super_cooldown")

func initialize_primary_cooldown():
	primary_cooldown_timer = primary_cooldown 
	emit_signal("begin_primary_cooldown", primary_cooldown)

func initialize_secondary_cooldown():
	secondary_cooldown_timer = secondary_cooldown 
	emit_signal("begin_secondary_cooldown", secondary_cooldown)

func initialize_ternary_cooldown():
	ternary_cooldown_timer = ternary_cooldown 
	emit_signal("begin_ternary_cooldown", ternary_cooldown)

func initialize_super_cooldown():
	super_cooldown_timer = super_cooldown 
	emit_signal("begin_super_cooldown", super_cooldown)

func _process(delta):
	if primary_cooldown_timer > 0:
		primary_cooldown_timer -= delta
	if secondary_cooldown_timer > 0:
		secondary_cooldown_timer -= delta
	if ternary_cooldown_timer > 0:
		ternary_cooldown_timer -= delta
	if super_cooldown_timer > 0:
		super_cooldown_timer -= delta