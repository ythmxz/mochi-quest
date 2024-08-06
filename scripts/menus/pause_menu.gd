extends CanvasLayer


# Atribui a tecla "cancel" como botão de pausa.
func _unhandled_input(event : InputEvent) -> void:

	if event.is_action_pressed("cancel"):

		visible = true
		get_tree().paused = true


func _on_resume_button_pressed() -> void:

	get_tree().paused = false
	visible = false


func _on_restart_button_pressed() -> void:

	get_tree().paused = false
	get_tree().reload_current_scene()
	Globals.reset_progress()


func _on_main_menu_button_pressed() -> void:

	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
