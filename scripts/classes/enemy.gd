extends CharacterBody2D
class_name Enemy


const SPEED : float = 1200.0

var gravity : float = 980.0
var direction : int = -1

@export var inverted : bool = false
@export var enemy_score : int

var sprite : AnimatedSprite2D
var wall_detector : RayCast2D

var can_spawn : bool = false
var spawn_scene : PackedScene = null
var spawn_scene_position : Marker2D


# Aplica a gravidade.
func _gravity(delta : float) -> void:

	if not is_on_floor():
		velocity.y += gravity * delta


# Possibilita o movimento.
func movement(delta : float) -> void:

	velocity.x = direction * SPEED * delta

	move_and_slide()


# Inverte a direção ao colidir.
func flip_direction() -> void:

	if wall_detector.is_colliding() or inverted == true:

		direction *= -1
		wall_detector.scale.x *= -1

	inverted = false

	if direction == 1:
		sprite.flip_h = true
	elif direction == -1:
		sprite.flip_h = false


# Pontua o "Player", elimina o inimigo e cria um novo, caso possível.
func kill_enemy() -> void:

	Globals.score += enemy_score

	if can_spawn == true:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()


# Gera o novo imimigo e o posiciona corretamente.
func spawn_new_enemy() -> void:

	var enemy_instance = spawn_scene.instantiate()
	get_tree().root.add_child(enemy_instance)

	enemy_instance.global_position = spawn_scene_position.global_position


# Gerencia o dano ao inimigo.
func _on_hitbox_body_entered(_body) -> void:
	sprite.play("hurt")
