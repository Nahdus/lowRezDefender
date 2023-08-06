extends State

var state_name = "passive_state"
var _time = 0
var _beat = 0.3

func enter(arg=null):
	print_debug(arg)

func exit(arg=null):
	print_debug(arg)
	print_debug("exiting %s"%state_name)

func step():
	_state_machine.transistion_to_state("active_state")

func process(delta):
	_time+=delta
	if _time>_beat:
		step()
		_time = 0
	
	

