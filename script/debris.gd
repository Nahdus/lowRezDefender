extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var Decay_timer = load("res://scene/derbis_decay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func add_debri_at(pos):
	var debriMap = $debriMap
	debriMap.set_cell(pos.x,pos.y,0)
	debriMap.add_explosion(Vector2(pos.x,pos.y))
	
	var decay_timer = Decay_timer.instance()
	add_child(decay_timer)
	decay_timer.connect("timeout",self,"_on_derbis_decay_timeout",[pos,decay_timer])
	
	decay_timer.start()
	

func remove_derbi_at(pos):
	$debriMap.set_cell(pos.x,pos.y,-1)


func _on_derbis_decay_timeout(pos,dc_t):
	remove_derbi_at(Vector2(pos[0],pos[1]))
	dc_t.queue_free()
		
