extends Node2D


var origin = [Vector2(47,0),Vector2(64,18),Vector2(64,46),Vector2(46,63),Vector2(17,64),Vector2(0,46),Vector2(0,18),Vector2(17,0)]
var rotations = [0,0,90,90,180,180,270,270]

var Invader = load('res://scene/invader.tscn')
var invader



func _ready():
	$InvaderTimer.start()
#	add_invader()
	pass
	
	
func add_invader():
	randomize()
	var index=int(floor(rand_range(0,len(origin))))
#	print_debug(index)
#	index = 7
	invader = Invader.instance()
	add_child(invader)
	invader.drop_invader(origin[index],rotations[index],index)
	invader.start()
	
func add_debris(pos):
	print_debug("debri")
	print_debug(pos)
	pass

func remove_invader(node):
	node.queue_free()
	pass


func _on_Timer_timeout():
	add_invader()
	pass # Replace with function body.
