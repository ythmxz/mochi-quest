extends Enemy


func _ready() -> void:

	# Atribui as variáveis utilizadas.
	sprite = $Sprite
	wall_detector = $WallDetector
	enemy_score = 75

	# Aplica a morte do inimigo.
	sprite.animation_finished.connect(kill_enemy)


func _physics_process(delta : float) -> void:

# Chama as funcões necessárias da classe.
	_gravity(delta)
	movement(delta)
	flip_direction()
