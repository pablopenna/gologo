class_name State extends Node

signal changeState

func emitChangeState(newState):
	emit_signal("changeState", newState)

func enter():
	pass
	
func process():
	pass
	
func exit():
	pass
