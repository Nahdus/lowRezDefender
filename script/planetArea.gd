extends Area2D

onready var map = get_parent()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_planetArea_body_entered(body):
	if body.name =="invader":
		map.remove_invader(body)
		
	
