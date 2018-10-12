extends "res://Player/IMoving.gd"

var cast_velocity = 2
var pressedMoves = [0, 0, 0, 0]
var castInput = 0

func enter():
	VELOCITY = cast_velocity

func update(delta):
	# Check casting actions.
	castInput = int(Input.is_action_pressed("craft"))
	if(castInput == 0):
		emit_signal("finished", "casting")
	
	# Add currently pressed spells to the crafting container.
	addCraftingAbilities()
	
	# Determine which movement inputs have been used this update.
	fillPressedArray(pressedMoves)
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)

func addCraftingAbilities():
	if(Input.is_action_just_pressed("primary_ability")):
		owner.add_to_crafting(0)
	if(Input.is_action_just_pressed("secondary_ability")):
		owner.add_to_crafting(1)
	if(Input.is_action_just_pressed("ternary_ability")):
		owner.add_to_crafting(2)
	if(Input.is_action_just_pressed("super_ability")):
		owner.add_to_crafting(3)