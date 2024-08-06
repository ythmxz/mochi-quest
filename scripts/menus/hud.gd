extends Control


@export_range(0, 59) var default_minutes : int = 1
@export_range(0, 59)var default_seconds : int = 0
var minutes : int = 0
var seconds : int = 0

@onready var timer = $Timer as Timer
@onready var life_counter = $Container/LeftContainer/VBoxContainer/LifeContainer/LifeCounter as Label
@onready var coin_counter = $Container/LeftContainer/VBoxContainer/CoinContainer/CoinCounter as Label
@onready var score_counter = $Container/RightContainer/VBoxContainer/ScoreContainer/ScoreCounter as Label
@onready var time_counter = $Container/RightContainer/VBoxContainer/TimeContainer/TimeCounter as Label

signal time_is_up()


# Atribui as informações ao texto do HUD.
func _ready() -> void:

	get_parent().visible = true

	life_counter.text = str("%02d" % Globals.health)
	coin_counter.text = str("%03d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	time_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)

	reset_timer()


func _process(_delta : float) -> void:

	# Sincroniza o texto do HUD com as informações.
	life_counter.text = str("%02d" % Globals.health)
	coin_counter.text = str("%03d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	time_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

	# Sinaliza o fim do tempo.
	if minutes == 0 and seconds == 0:
		emit_signal("time_is_up")


func reset_timer() -> void:

	minutes = default_minutes
	seconds = default_seconds


# Gerencia o relógio da fase.
func _on_timer_timeout() -> void:

	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60

	seconds -= 1
