extends AnimatableBody2D


var gravity : float = 980.0
var velocity : Vector2 = Vector2.ZERO

@export_range(0.5, 10.0) var gravity_force : float = 1.0
@export var reset_timer : float = 3.0
var is_triggered : bool = false

@onready var sprite = $Sprite as Sprite2D
@onready var animation = $Animation as AnimationPlayer
@onready var respawn_timer = $RespawnTimer as Timer
@onready var respawn_position : Vector2 = global_position


func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta : float) -> void:

	velocity.y += (gravity_force * gravity) * delta
	position += velocity * delta


# Detecta colisões e ativa a plataforma.
func has_collided_with(_collision : KinematicCollision2D, _collider : CharacterBody2D) -> void:

	if is_triggered == false:

		is_triggered = true

		animation.play("shake")

		velocity = Vector2.ZERO


# Derruba a plataforma.
func _on_animation_animation_finished(_anim_name : StringName) -> void:

	set_physics_process(true)

	respawn_timer.start(reset_timer)


# Reposiciona a plataforma.
func _on_respawn_timer_timeout() -> void:

	set_physics_process(false)

	global_position = respawn_position

	if is_triggered == true:

		var spawn_tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		spawn_tween.tween_property(sprite, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))

	is_triggered = false
