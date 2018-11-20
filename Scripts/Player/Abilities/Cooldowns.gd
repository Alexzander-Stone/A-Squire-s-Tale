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
	casting_node.connect("crafting_used", self, "initialize_multiple_cooldowns")

func initialize_primary_cooldown(args):
	primary_cooldown_timer = primary_cooldown * (1 - $"../Stats".mcdr) 
	emit_signal("begin_primary_cooldown", primary_cooldown * (1 - $"../Stats".mcdr))

func initialize_secondary_cooldown(args):
	secondary_cooldown_timer = secondary_cooldown * (1 - $"../Stats".mcdr)
	emit_signal("begin_secondary_cooldown", secondary_cooldown* (1 - $"../Stats".mcdr))

func initialize_ternary_cooldown(args):
	ternary_cooldown_timer = ternary_cooldown * (1 - $"../Stats".mcdr)
	print(ternary_cooldown_timer)
	emit_signal("begin_ternary_cooldown", ternary_cooldown* (1 - $"../Stats".mcdr))

func initialize_super_cooldown(args):
	super_cooldown_timer = super_cooldown * (1 - $"../Stats".mcdr)
	emit_signal("begin_super_cooldown", super_cooldown* (1 - $"../Stats".mcdr))

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

# Given the ID number of the ability (0-3), return a boolean corresponding to if the 
# cooldown is currently running.
func is_cooldown_running_for(ability_number_id):
	match ability_number_id:
		0:
			return true if primary_cooldown_timer > 0 else false
		1:
			return true if secondary_cooldown_timer > 0 else false
		2:
			return true if ternary_cooldown_timer > 0 else false
		3:
			return true if super_cooldown_timer > 0 else false
	printerr("Ability number id was invalid in Cooldowns of Player")

func _process(delta):
	if primary_cooldown_timer > 0:
		primary_cooldown_timer -= delta
	if secondary_cooldown_timer > 0:
		secondary_cooldown_timer -= delta
	if ternary_cooldown_timer > 0:
		ternary_cooldown_timer -= delta
	if super_cooldown_timer > 0:
		super_cooldown_timer -= delta