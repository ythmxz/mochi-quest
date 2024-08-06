extends Node


var health : int = 3
var score : int = 0
var coins : int = 0

var player : CharacterBody2D = null
var player_start_position = null
var current_checkpoint = null


# Gerencia o ressurgimento do "Player" e os checkpoints.
func respawn_player() -> void:

	if current_checkpoint != null:
		player.global_position = current_checkpoint.global_position
	else:
		player.global_position = player_start_position.global_position

	health = 3
	score -= 500

	if score < 0:
		score = 0


# Redefine as informações do "Player".
func reset_progress() -> void:

	health = 3
	score = 0
	coins = 0
