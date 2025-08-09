extends Node

@onready var pause_menu: Control = $CanvasLayer/pause_menu

func _ready() -> void:
	pause_menu.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = not get_tree().paused
		pause_menu.visible = get_tree().paused
		
