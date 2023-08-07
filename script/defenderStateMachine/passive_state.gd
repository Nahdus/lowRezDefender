extends State

var state_name = "passive_state"
var _time = 0
var _beat = 0.2

var buffer = []

func enter(arg=null):
	pass
#	print_debug(arg)

func exit(arg=null):
	_state_machine.set_inter_state_args(buffer)
	buffer = []
	pass
#	print_debug(arg)
#	print_debug("exiting %s"%state_name)

func step():
	_state_machine.transistion_to_state("active_state")

func get_input():
	return {
		"rotate_right":Input.is_action_just_pressed("rotate_right"),
		"rotate_left":Input.is_action_just_pressed("rotate_left")
	}

func process(delta):
	_time+=delta
	if get_input()["rotate_right"]:
		buffer.append("right")
	if get_input()["rotate_left"]:
		buffer.append("left")
	if _time>_beat:
		step()
		_time = 0
	
	

