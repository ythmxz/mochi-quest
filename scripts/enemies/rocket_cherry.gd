extends Enemy


@onready var spawner = $"../Spawner" as Marker2D


func _ready() -> void:

	sprite = $Sprite
	enemy_score = 75
	can_spawn = true
	spawn_scene = preload("res://scenes/enemies/cherry.tscn")
	spawn_scene_position = spawner

	sprite.animation_finished.connect(kill_enemy)
