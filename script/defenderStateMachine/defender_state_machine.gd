extends StateMachine

var stat_object_dict = {}
var transistion_table = {}
var current_state

func set_target(target):
	_target=target
	
func add_state(state,transistion_list):
	stat_object_dict[state.state_name] = state
	transistion_table[state.state_name] = transistion_list

func set_current_state(state):
	current_state = state

func transistion_to_state(state_name):
	if state_name in transistion_table[current_state.state_name]:
		current_state.exit()
		current_state = stat_object_dict[state_name]
		current_state.enter()
	else:
		print_debug("cant transistion from %s to %s"%[current_state.state_name,state_name])
		
		
func process(delta):
	current_state.process(delta)
