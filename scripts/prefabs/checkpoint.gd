extends Area2D


var is_active : bool = false

@onready var sprite = $Sprite as AnimatedSprite2D
@onready var marker = $Marker as Marker2D


# Detecta se o checkpoint está livre e o ativa.
func _on_body_entered(body : CharacterBody2D) -> void:

	if body.name != "Player" or is_active == true:
		return

	activate_checkpoint()


# Define o checkpoint como ponto de ressurgimento.
func activate_checkpoint() -> void:

	Globals.current_checkpoint = marker

	sprite.play("activating")

	is_active = true


func _on_sprite_animation_finished() -> void:

	if sprite.animation == "activating":
		sprite.play("active")
