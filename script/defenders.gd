extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var defender_pos = [Vector2(34,26),Vector2(38,29),Vector2(38,34),Vector2(35,38),Vector2(30,38),Vector2(26,34),Vector2(26,30),Vector2(29,26)]
var defender_rotation = [0,90,90,180,180,270,270,0]
var active_turret = [0,0,0,0,0,0,0,0]
var original_turret = [1,0,0,0,1,0,0,0]
var flip = []
var rotation_offset = 0

#state Machine
var Defender_state_machine = load("res://script/defenderStateMachine/defender_state_machine.gd")
var defender_state_machine
#states
var ActiveState = load("res://script/defenderStateMachine/active_state.gd")
var active_state
var PassiveState = load("res://script/defenderStateMachine/passive_state.gd")
var passive_state

var Turret = load("res://scene/turret.tscn")
# Called when the node enters the scene tree for the first time

func set_up_state(machine,state_object):
	var state = state_object.new()
	machine.set_target(self)
	state.set_target(self)
	state.set_state_machine(machine)
	return state


func create_state_machine():
	defender_state_machine = Defender_state_machine.new()
	set_up_state(defender_state_machine,ActiveState)
	set_up_state(defender_state_machine,PassiveState)
	var active_state = set_up_state(defender_state_machine,ActiveState)
	var passive_state = set_up_state(defender_state_machine,PassiveState)
	defender_state_machine.add_state(active_state,["passive_state"])
	defender_state_machine.add_state(passive_state,["active_state"])
	defender_state_machine.set_current_state(active_state)


func _ready():
	active_turret = original_turret
	position_turret()
	create_state_machine()
	
	
func clear_turrets():
	var childeren = get_children()
	for each in childeren:
		if "turret" in each.name:
			print_debug(each)
			each.queue_free()

func position_turret():
	var idx = 0
	clear_turrets()
	for each in active_turret:
		if each == 1:
			var turret = Turret.instance()
			turret.set_position(defender_pos[idx])
			turret.set_rotation_degrees(defender_rotation[idx])
			add_child(turret)
		idx+=1

func rotate_left():
	var rotated_turret = []
#	var original_turret = [1,0,0,0,0,1,0,0]
	rotated_turret.resize(len(original_turret))
	rotation_offset+=1
	rotation_offset = (rotation_offset)%len(original_turret)
	for idx in range(len(active_turret)):
		rotated_turret[idx] = original_turret[(rotation_offset+idx)%len(original_turret)]
	active_turret=rotated_turret
	print_debug(rotation_offset)
	print_debug(active_turret)
	position_turret()
	
func rotate_right():
	var rotated_turret = []
#	var original_turret 
	rotated_turret.resize(len(original_turret))
	if rotation_offset>0:
		rotation_offset-=1
	else:
		rotation_offset = len(original_turret) -1
	rotation_offset = (rotation_offset)%len(original_turret)
	for idx in range(len(active_turret)):
		rotated_turret[idx] = original_turret[(rotation_offset+idx)%len(original_turret)]
	active_turret=rotated_turret
	print_debug(rotation_offset)
	print_debug(active_turret)
	position_turret()
	
func get_bullet_map():
	return get_parent()
	
func _process(delta):
	defender_state_machine.process(delta)
	
	
func fire_turret():
	for idx in range(len(active_turret)):
		if active_turret[idx] == 1:
			$bullets.spawn_bullet(idx)
