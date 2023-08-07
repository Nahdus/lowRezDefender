extends State

var state_name = "active_state"

var dir
var buffered_input = []

func enter(arg = null):
	if arg:
		if len(arg)>0:
			buffered_input = buffered_input + arg
	

func exit(arg = null):
	pass


func get_input():
	return {
		"rotate_right": Input.is_action_pressed("rotate_right"),
		"rotate_left": Input.is_action_pressed("rotate_left"),
		"fire": Input.is_action_pressed("fire")
	}
	
	
func execute_buffer(buffinp):
	if len(buffinp)>1:
		if buffinp[0]=="right":
			_target.rotate_right()
#			_state_machine.transistion_to_state("passive_state")
			buffered_input.pop_front()
	if len(buffinp)>1:
		if buffinp[0]=="left":
			_target.rotate_left()
#			_state_machine.transistion_to_state("passive_state")
			buffered_input.pop_front()


func process(delta):
	if len(buffered_input)>0:
		execute_buffer(buffered_input)
	if get_input()["rotate_right"]:
		_target.rotate_right()
		_state_machine.transistion_to_state("passive_state")
	if get_input()["rotate_left"]:
		_target.rotate_left()
		_state_machine.transistion_to_state("passive_state")
	if get_input()["fire"]:
		_target.fire_turret()
		_state_machine.transistion_to_state("passive_state")

