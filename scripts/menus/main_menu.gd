extends Control


@onready var animation = $Animation as AnimationPlayer


# Gerencia a animação do título.
func _ready() -> void:

	Globals.reset_progress()

	await get_tree().create_timer(4.0).timeout

	animation.play("float")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_01.tscn")



func _on_credits_button_pressed() -> void:
	pass


func _on_quit_button_pressed() -> void:
	get_tree().quit()
