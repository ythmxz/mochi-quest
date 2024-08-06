extends Area2D


@export var next_level : String = ""

@onready var transition = $"../../UI/Transition" as CanvasLayer


# Redireciona o "Player" para a próxima fase.
func _on_body_entered(body: CharacterBody2D) -> void:

	if body.name == "Player" and next_level != "":
		transition.change_scene(next_level)
