extends CharacterBody2D


const SPEED : float = 100.0
const AIR_FRICTION : float = 0.5

var direction : float

var gravity : float
var fall_gravity : float

var jump_velocity : float
@export var jump_height : int = 64
@export var peak_time : float = 0.5

var took_damage : bool = false
var knockback : Vector2 = Vector2.ZERO
@export var default_knockback : float = 200.0

@onready var sprite = $Sprite as AnimatedSprite2D
@onready var remote = $Remote as RemoteTransform2D
@onready var ray_left = $RayLeft as RayCast2D
@onready var ray_right = $RayRight as RayCast2D
@onready var jump_sfx = $JumpSFX as AudioStreamPlayer
@onready var break_sfx = preload("res://scenes/resources/break_sfx.tscn") as PackedScene

signal has_died


func _ready() -> void:

	# Fórmula do pulo.
	gravity = (jump_height * 2) / pow(peak_time, 2)
	jump_velocity = (jump_height * 2) / peak_time
	fall_gravity = gravity * 2


func _physics_process(delta : float) -> void:

	# Adiciona a gravidade.
	if not is_on_floor():
		velocity.x /= 1.25

	if velocity.y > 0 or not Input.is_action_pressed("jump"):
		velocity.y += fall_gravity * delta
	else:
		velocity.y += gravity * delta

	# Adiciona o pulo.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
		jump_sfx.play()

	# Obtém a direção e adiciona o movimento.
	direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, AIR_FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if knockback != Vector2.ZERO:
		velocity = knockback

	# Inverte o sprite com base na direção.
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	set_state()
	move_and_slide()

	# Indica a colisão para a "FallingPlatform".
	for platform in get_slide_collision_count():

		var collision : KinematicCollision2D = get_slide_collision(platform)

		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)


# Gerencia as animações.
func set_state() -> void:

	var state : String = "idle"

	if not is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"

	if took_damage == true:
		state = "hurt"

	if sprite.name != state:
		sprite.play(state)


func follow_camera(camera: Camera2D) -> void:

	var camera_path = camera.get_path()
	remote.remote_path = camera_path


# Gerencia o dano e o knockback.
func take_damage(knockback_intensity : Vector2 = Vector2.ZERO, duration : float = 0.25) -> void:

	# Reduz a vida e mata o "Player".
	if Globals.health > 0:
		Globals.health -= 1
	if Globals.health <= 0:
		Globals.health = 0
		queue_free()
		emit_signal("has_died")

	# Aplica a intensidade do knockback.
	if knockback_intensity != Vector2.ZERO:
		knockback = knockback_intensity

	# Produz a annimação de knockback.
	var knockback_tween : Tween = get_tree().create_tween()
	knockback_tween.parallel().tween_property(self, "knockback", Vector2.ZERO, duration)
	sprite.modulate = Color(1, 0, 0, 1)
	knockback_tween.parallel().tween_property(sprite, "modulate", Color(1, 1, 1, 1), duration)

	# Sinaliza para a animação "hurt".
	took_damage = true

	await get_tree().create_timer(0.3).timeout

	took_damage = false


# Aplica o dano e o knockback quando toca em um inimigo.
func _on_hurtbox_body_entered(_body : CharacterBody2D) -> void:

	if ray_left.is_colliding():
		take_damage(Vector2(default_knockback, -default_knockback))
	elif ray_right.is_colliding():
		take_damage(Vector2(-default_knockback, -default_knockback))


# Ataca e quebra blocos quando cabeçeados.
func _on_head_attack_body_entered(body : CharacterBody2D):

	if body.has_method("break_block"):
		body.hit_points -= 1

		if body.hit_points <= 0:
			body.break_block()
		else:
			body.animation.play("hit")
			body.hit_sfx.play()
			body.create_coin()


func play_break_sfx():

	var sfx_instance = break_sfx.instantiate()
	get_parent().add_child(sfx_instance)

	sfx_instance.play()

	await sfx_instance.finished

	sfx_instance.queue_free()
