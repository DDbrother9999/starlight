extends Node2D

@export var value: int = 1

func _ready():
	if get_name() in GameController.collectedCoinIDs:
		queue_free() 

func _on_area_2d_body_entered(body):
	if body is Player:
		GameController.CollectCoinWithID(get_name(), value)
		self.queue_free()
