extends Node3D


signal collected

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("car"):
		collected.emit()
		queue_free()
