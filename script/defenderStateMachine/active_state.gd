extends State

var state_name = "active_state"

var dir

func enter(arg = null):
	print_debug(arg)

func exit(arg = null):
	print_debug(arg)
	print_debug("exiting %s"%state_name)


func get_input():
	return {
		"rotate_right": Input.is_action_pressed("rotate_right"),
		"rotate_left": Input.is_action_pressed("rotate_left"),
		"fire": Input.is_action_pressed("fire")
	}

func process(delta):
	if get_input()["rotate_right"]:
		_target.rotate_right()
		_state_machine.transistion_to_state("passive_state")
	if get_input()["rotate_left"]:
		_target.rotate_left()
		_state_machine.transistion_to_state("passive_state")
	if get_input()["fire"]:
		_target.fire_turret()
		_state_machine.transistion_to_state("passive_state")

