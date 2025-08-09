extends Node2D

enum PlatformType { LIGHT, DARK }

@export var type: PlatformType = PlatformType.LIGHT

func _ready() -> void:
	EventController.isLightOn.connect(_on_light_state_changed)
	_on_light_state_changed(true)

func _on_light_state_changed(is_light_on: bool) -> void:
	var should_be_visible: bool

	if type == PlatformType.LIGHT:
		should_be_visible = is_light_on
	else:
		should_be_visible = not is_light_on

	var tween = create_tween()
	var target_alpha = 1.0 if should_be_visible else 0.0

	$CollisionShape2D.disabled = not should_be_visible
	tween.tween_property($Sprite2D, "modulate:a", target_alpha, 0.5).set_trans(Tween.TRANS_SINE)
