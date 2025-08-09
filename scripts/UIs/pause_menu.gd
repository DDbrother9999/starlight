extends Control

func _on_button_resume_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_button_restart_pressed() -> void:
	get_tree().paused = false
	GameController.ResetGameStats()
	get_tree().reload_current_scene()

func _on_button_main_menu_pressed() -> void:
	GameController.SaveGame()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
