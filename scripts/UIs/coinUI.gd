extends Control
@onready var label = $Label

func _ready():
	EventController.connect("coinsCollected", EventCoinCollected)
	label.text = str(GameController.coins)
	
func EventCoinCollected(value: int) -> void:
	label.text = str(GameController.coins)
