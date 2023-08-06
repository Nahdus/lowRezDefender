class_name State
extends Resource

var _target
var _state_machine

func set_target(target):
	_target = target
	
func set_state_machine(state_machine):
	_state_machine = state_machine
	
func process(delta):
	pass
