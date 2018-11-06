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

export(NodePath) var casting_path
onready var casting_node = get_node(casting_path)

func _ready():
	# Begin listening to casting node for cooldown directions.
	casting_node.connect("primary_used", self, "initialize_primary_cooldown")
	casting_node.connect("secondary_used", self, "initialize_secondary_cooldown")
	casting_node.connect("ternary_used", self, "initialize_ternary_cooldown")
	casting_node.connect("super_used", self, "initialize_super_cooldown")
	casting_node.connect("crafting_used", self, "initialize_multiple_cooldowns")

func initialize_primary_cooldown(args):
	primary_cooldown_timer = primary_cooldown 
	emit_signal("begin_primary_cooldown", primary_cooldown)

func initialize_secondary_cooldown(args):
	secondary_cooldown_timer = secondary_cooldown 
	emit_signal("begin_secondary_cooldown", secondary_cooldown)

func initialize_ternary_cooldown(args):
	ternary_cooldown_timer = ternary_cooldown 
	emit_signal("begin_ternary_cooldown", ternary_cooldown)

func initialize_super_cooldown(args):
	super_cooldown_timer = super_cooldown 
	emit_signal("begin_super_cooldown", super_cooldown)

func initialize_multiple_cooldowns(ability_key, args):
	for ability in ability_key:
		match ability:
			"0":
				initialize_primary_cooldown(args)
			"1":
				initialize_secondary_cooldown(args)
			"2":
				initialize_ternary_cooldown(args)
			"3":
				initialize_super_cooldown(args)

func _process(delta):
	if primary_cooldown_timer > 0:
		primary_cooldown_timer -= delta
	if secondary_cooldown_timer > 0:
		secondary_cooldown_timer -= delta
	if ternary_cooldown_timer > 0:
		ternary_cooldown_timer -= delta
	if super_cooldown_timer > 0:
		super_cooldown_timer -= delta