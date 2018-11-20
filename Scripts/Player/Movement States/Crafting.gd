extends "res://Scripts/Player/Movement States/Inheritable Classes/IMoving.gd"

var pressedMoves = [0, 0, 0, 0]
var castInput = 0

func enter(args):
	# Reset crafting container. Needed for interaction transitions.
	owner.crafting_container.clear()
	.enter(args)

func update(delta):
	VELOCITY = $"../../Stats".mWalkSpeed/2
	# Check casting actions.
	castInput = int(Input.is_action_pressed("craft"))
	if(castInput == 0):
		emit_signal("finished", "casting", [-1])
	
	# Add currently pressed spells to the crafting container.
	addCraftingAbilities()
	
	# Determine which movement inputs have been used this update.
	fillPressedArray(pressedMoves)
	
	# Determine which direction to move the player based on given inputs.
	movePlayer(pressedMoves)
	
	# Call parent class function.
	.update(delta)

func addCraftingAbilities():
	if(Input.is_action_just_pressed("primary_ability")):
		owner.add_to_crafting(0)
	if(Input.is_action_just_pressed("secondary_ability")):
		owner.add_to_crafting(1)
	if(Input.is_action_just_pressed("ternary_ability")):
		owner.add_to_crafting(2)
	if(Input.is_action_just_pressed("super_ability")):
		owner.add_to_crafting(3)
		
func exit():
	.exit()