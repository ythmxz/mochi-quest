extends Area2D


@export var coin_score : int = 10

@onready var sprite = $Sprite as AnimatedSprite2D
@onready var collision = $Collision as CollisionShape2D
@onready var coin_sfx = $CoinSFX as AudioStreamPlayer


# Pontua o "Player" e coleta a moeda.
func _on_body_entered(_body : CharacterBody2D) -> void:

	sprite.play("collect")
	coin_sfx.play()

	await collision.call_deferred("queue_free")

	Globals.coins += 1
	Globals.score += coin_score


func _on_sprite_animation_finished() -> void:
	queue_free()
