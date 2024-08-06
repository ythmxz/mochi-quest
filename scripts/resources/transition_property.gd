extends ColorRect


var threshold : float = 0.0


func _process(_delta : float) -> void:
	material.set("shader_parameter/threshold", threshold)
