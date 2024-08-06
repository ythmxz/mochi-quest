extends CharacterBody2D


const BLOCK_PIECES : PackedScene = preload("res://scenes/resources/block_pieces.tscn")
const COIN_SCENE : PackedScene = preload("res://scenes/resources/block_coin.tscn")

var impulse : int = 100
@export var pieces : PackedStringArray
@export var hit_points : int = 3

@onready var animation = $Animation as AnimationPlayer
@onready var hit_sfx = $HitSFX as AudioStreamPlayer
@onready var coin_spawner = $CoinSpawner as Marker2D


# Gera os pedaços do bloco e os impulsiona para cima.
func break_block() -> void:

	for piece in pieces.size():

		var piece_instance = BLOCK_PIECES.instantiate()
		get_parent().add_child(piece_instance)

		piece_instance.get_node("Sprite").texture = load(pieces[piece])
		piece_instance.global_position = global_position
		piece_instance.apply_impulse(Vector2(randf_range(-impulse, impulse), randf_range(-impulse, -impulse * 2)))

		queue_free()


# Gera a moeda que sai do bloco quando cabeçeado.
func create_coin() -> void:

	var coin_instance = COIN_SCENE.instantiate()
	get_parent().call_deferred("add_child", coin_instance)

	coin_instance.global_position = coin_spawner.global_position
	coin_instance.apply_impulse(Vector2(randf_range(-50, 50), 150))
