extends KinematicBody2D


var PATH_CELL_INDEX = 0

var _time = 0
var beat = 0.1
var move= false

var rotations = [0,90,180,270]
var pathfinders = ["pathfinder22","pathfinder67","pathfinder112","pathfinder167","pathfinder212","pathfinder257","pathfinder302","pathfinder347"]
var shift_offsets = [Vector2(1,0),Vector2(1,0),Vector2(1,1),Vector2(1,1),Vector2(0,1),Vector2(0,1),Vector2(0,0),Vector2(0,0)]


var pathfinderNodeName
var currentShiftOffset 

#$KinematicBody2D/deftop.set_rotation_degrees([67.5,22.5][index%2])


onready var path:TileMap = get_parent().get_parent()
#onready var pathFinder:Node2D = get_node("pathfinder")

func _ready():
	pass
	
func start():
	move = true	
	
	
func set_pathfinder_node_with_index(idx):
	pathfinderNodeName = pathfinders[idx]
	
func drop_invader(pos,angle,pathfinderIndex):
	self.set_position(Vector2(pos.x,pos.y))
#	print_debug(angle/45)
	pathfinderNodeName = pathfinders[pathfinderIndex]
	currentShiftOffset = shift_offsets[pathfinderIndex]
#	print_debug(pathfinderNodeName)
	self.set_rotation_degrees(angle)
	pass
	
	

func find_next_pos():
	for sensor in get_node(pathfinderNodeName).get_children():
		var sensor_global_position = sensor.get_global_position()
		var cell = path.get_cell(sensor_global_position.x,sensor_global_position.y)
#		print_debug(sensor_global_position)
#		print_debug(cell)
		if cell == PATH_CELL_INDEX:
			return sensor_global_position
	
	
func reposition(pos:Vector2):
	self.set_position(Vector2(pos.x,pos.y)+currentShiftOffset)
	find_next_pos()

func despawn_invader():
	self.queue_free()

func update_position():
	var pos=find_next_pos()
	if !pos:
		self.queue_free()
	else:
		reposition(pos)


func _process(delta):
	if move:
		_time+=delta
		if _time >beat:
			update_position()
			_time = 0
	
func shatter_invader():
	get_parent().add_debris(self.position)
	$Sprite.visible = false
	$despawn_timer.start()
	

func _on_Area2D_body_entered(body):
	if "bullet" in body.name:
#		print_debug("hit by a bullet")
		shatter_invader()
	pass # Replace with function body.


func _on_despawn_timer_timeout():
	self.queue_free()
	pass # Replace with function body.
