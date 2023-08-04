extends Node2D

var bullet_spawn_points = [Vector2(35,25),Vector2(39,28),Vector2(38,34),Vector2(35,38),Vector2(30,38),Vector2(25,35),Vector2(25,28),Vector2(28,25)]
var bullet_rotation = [0,90,90,180,180,270,270]
var bullet_scene = load("res://scene/bullet.tscn")




var bullet_path


func _ready():
	
#	print_debug(bullet_path)
	spawn_bullet(4)
	pass # Replace with function body.



func spawn_bullet(idx):
	var bullet = bullet_scene.instance()
	bullet.position_bullet(bullet_spawn_points[idx],bullet_rotation[idx],idx)
	add_child(bullet)
	bullet.set_bullet_map(get_parent().get_bullet_map())
	bullet.fire()
	pass
