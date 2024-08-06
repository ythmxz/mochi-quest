extends Area2D


func _on_body_entered(body : CharacterBody2D) -> void:

	if body.name == "Player":

		body.velocity.y = -200.0

		get_parent().sprite.play("hurt")
