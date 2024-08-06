extends Control


func _ready() -> void:
	Globals.reset_progress()


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")



func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
