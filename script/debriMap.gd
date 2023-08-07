extends TileMap

onready var Explosion = load("res://scene/explosion.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_explosion(pos):
	var explosion = Explosion.instance()
	explosion.set_position(pos)
	add_child(explosion)
	explosion.connect("animation_finished",self,"animation_ended",[explosion])
	explosion.play()


func animation_ended(explosion):
	explosion.queue_free()
	
