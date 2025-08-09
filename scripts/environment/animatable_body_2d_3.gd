extends AnimatableBody2D

@export var travel: Vector2 = Vector2(-300, 0)

@export var duration: float = 4.0

func _ready():
	var tween = create_tween()
	
	tween.set_loops()
	tween.tween_property(self, "position", position + travel, duration / 2.0)
	tween.tween_property(self, "position", position, duration / 2.0)
