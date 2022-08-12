extends Node

signal changeState

func changeState(newState):
	emit_signal("changeState", newState)

func enter():
	pass
	
func process():
	pass
	
func exit():
	pass
