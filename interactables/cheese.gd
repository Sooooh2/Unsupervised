extends Node3D

signal cheese_collected

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("car"):
		cheese_found()


func cheese_found() -> void:
	cheese_collected.emit()
	hide()
