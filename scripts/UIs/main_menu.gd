extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options_buttons: Panel = $OptionsButtons

func _ready() -> void:
	get_tree().paused = false
	main_buttons.visible = true
	options_buttons.visible = false

func _on_button_start_pressed() -> void:
	GameController.LoadGame()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_button_options_pressed() -> void:
	main_buttons.visible = false
	options_buttons.visible = true

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _on_button_back_pressed() -> void:
	main_buttons.visible = true
	options_buttons.visible = false
