extends StaticBody2D

@onready var light_2d = $PointLight2D

var is_on: bool = true

func interact() -> void:
	is_on = not is_on
	light_2d.enabled = is_on

	EventController.emit_signal("isLightOn", is_on)
