extends Node

var currentState
var statesMap = {}

func initialize(newState):
	
	for state in statesMap.values():
		print_debug(state.name)
		state.connect("changeState", Callable(self, "changeState"))
	
	currentState = statesMap[newState]
	currentState.enter()

func changeState(newState):
	print_debug("MACHINE: changing to {}", newState)
	currentState.exit()
	currentState = statesMap[newState]
	currentState.enter()
