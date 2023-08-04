extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var defender_pos = [Vector2(34,26),Vector2(38,29),Vector2(38,34),Vector2(35,38),Vector2(30,38),Vector2(26,34),Vector2(26,30),Vector2(29,26)]
var defender_rotation = [0,90,90,180,180,270,270,0]
var active_turret = [1,0,0,0,0,0,0,0]
var flip = []
var rotation_offset = 0

onready var turret = get_node("turret")
# Called when the node enters the scene tree for the first time.
func _ready():
	rotate_right()
	position_turret()
func position_turret():
	var idx = 0
	for each in active_turret:
		if each == 1:
			turret.set_position(defender_pos[idx])
			turret.set_rotation_degrees(defender_rotation[idx])
		idx+=1

func rotate_left():
	var rotated_turret = []
	var original_turret = [1,0,0,0,0,0,0,0]
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
	var original_turret = [1,0,0,0,0,0,0,0]
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
