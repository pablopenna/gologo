extends "res://scripts/stateMachine/State.gd"

func process():
	if Input.is_action_just_pressed("player_right") or Input.is_action_just_pressed("player_left"):
		emit_signal("changeState", "move")
