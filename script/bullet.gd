extends KinematicBody2D


var _time = 0
var beat = 0.1
var bullet_map

var path_finders = ["pathfinder22","pathfinder67","pathfinder112","pathfinder157","pathfinder202","pathfinder247","pathfinder292","pathfinder337"]
#							[Vector2(47,0),Vector2(64,18),Vector2(64,46),Vector2(46,63),Vector2(17,64),Vector2(0,46),Vector2(0,18),Vector2(17,0)]
var bullet_despawn_points = [Vector2(46,0),Vector2(63,18),Vector2(63,45),Vector2(46,63),Vector2(17,63),Vector2(0,44),Vector2(0,18),Vector2(17,0)]
var position_offset = [Vector2(0,0),Vector2(1,0),Vector2(1,0),Vector2(1,1),Vector2(1,1),Vector2(0,1),Vector2(0,1),Vector2(0,0)]
var path_index = 0


var start = false


func set_bullet_map(map):
	print_debug(map)
	bullet_map = map

func fire():
	start = true

func stop_bullet():
	start  = false

func position_bullet(pos,angle,idx):
	path_index=idx
	self.set_position(pos)
	self.set_rotation_degrees(angle)

func despawn_bullet():
	self.queue_free()

func find_next_pos():
	var sensors = get_node(path_finders[path_index]).get_children()
	for each_sensor in sensors:
		var pos =each_sensor.get_global_position()
		var cell = bullet_map.get_cell(pos.x,pos.y)
		print_debug(cell)
		if cell == 0:
			return pos


func reposition():
	var pos = find_next_pos()
	self.set_position(pos+position_offset[path_index])
	if pos == bullet_despawn_points[path_index]:
		despawn_bullet()
	print_debug(self.position)
	

func _process(delta):
	if start:
		_time+=delta
		if _time>beat:
			reposition()
			_time = 0
	
