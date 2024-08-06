extends Area2D


@export var tiles : int = 1

@onready var sprite = $Sprite as Sprite2D
@onready var collision = $Collision as CollisionShape2D


# Molda a colisão ao formato do sprite.
func _ready() -> void:

	sprite.region_rect.size = Vector2(tiles * 16, 8)
	collision.shape.size = sprite.get_rect().size


func _on_body_entered(body: CharacterBody2D) -> void:

	if body.name == "Player" and body.has_method("take_damage"):
		body.take_damage(Vector2(0, -600))
