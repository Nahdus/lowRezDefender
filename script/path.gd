extends TileMap

onready var invaders = $invaders

func _ready():
	pass
#	invader.reposition(origin[0])
	

func remove_invader(node):
	invaders.remove_invader(node)

