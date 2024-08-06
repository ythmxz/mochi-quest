extends CanvasLayer


@onready var color = $Color as ColorRect


func _ready() -> void:
	visible = true


func change_scene(path : String, delay : float = 1.0) -> void:

	var transition_tween = get_tree().create_tween()
	transition_tween.tween_property(color, "threshold", 1.0, 1.0).set_delay(delay)

	await transition_tween.finished

	assert(get_tree().change_scene_to_file(path) == OK)


func show_new_scene() -> void:

	var show_tween : Tween = get_tree().create_tween()
	show_tween.tween_property(color, "threshold", 0.0, 1.0).from(1.0)
