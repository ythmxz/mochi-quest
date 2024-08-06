extends Node2D


var center : int = 16
var follow: Vector2 = Vector2.ZERO

@export var move_speed : float = 3.0
@export var wait_duration : float = 1.0
@export var distance : int = 4
@export var horizontal : bool = true
@export var inverted : bool = false

@onready var platform = $Platform as AnimatableBody2D


func _ready() -> void:
	move_platform()


func _physics_process(_delta : float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)


func move_platform() -> void:

	var move_direction : Vector2

	if horizontal == true:
		if inverted == false:
			move_direction = Vector2.RIGHT * (distance * 32)
		else:
			move_direction = Vector2.LEFT * (distance * 32)
	else:
		if inverted == false:
			move_direction = Vector2.UP * (distance * 16)
		else:
			move_direction = Vector2.DOWN * (distance * 16)

	var move_duration : float = move_direction.length() / float(move_speed * center)

	var move_tween : Tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	move_tween.tween_interval(wait_duration)
	move_tween.tween_property(self, "follow", move_direction, move_duration)
	move_tween.tween_interval(wait_duration)
	move_tween.tween_property(self, "follow", Vector2.ZERO, move_duration)
