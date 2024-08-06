extends Node2D


@onready var player = $Player as CharacterBody2D
@onready var player_scene = preload("res://scenes/player/player.tscn") as PackedScene
@onready var player_spawn = $Management/PlayerSpawn as Marker2D
@onready var camera = $Camera as Camera2D
@onready var hud = $UI/HUD as CanvasLayer
@onready var hud_control = hud.get_node("HUDControl") as Control


# Inicializa o gerenciamento da fase.
func _ready() -> void:

	Globals.player = player
	Globals.player_start_position = player_spawn
	Globals.player.follow_camera(camera)
	Globals.player.has_died.connect(restart_game)
	hud_control.time_is_up.connect(game_over)


# Ressurge o "Player" após morrer.
func restart_game():

	await get_tree().create_timer(1.0).timeout

	player = player_scene.instantiate()
	add_child(player)

	Globals.player = player
	Globals.player.follow_camera(camera)
	Globals.player.has_died.connect(restart_game)
	Globals.respawn_player()


func game_over():
	get_tree().change_scene_to_file("res://scenes/menus/game_over_menu.tscn")
