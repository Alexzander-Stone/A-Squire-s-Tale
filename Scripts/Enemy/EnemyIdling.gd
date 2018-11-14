extends "res://Scripts/Enemy/Enemy Inheritable Classes/IFlinchable.gdq"

func enter(args):
	owner.velocity = Vector2(0,0)
	# Check for Player to attack.
	if true:
		emit_signal("finished", "walking", [])
	.enter(args)


func update(delta):
	# Check for Player to attack.
	if true:
		emit_signal("finished", "walking", [])