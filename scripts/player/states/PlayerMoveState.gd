extends "res://scripts/stateMachine/State.gd"

func process():
	if !Input.is_action_pressed("player_right") and !Input.is_action_pressed("player_left"):
		emit_signal("changeState", "idle")
