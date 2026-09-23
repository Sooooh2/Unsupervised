@tool
class_name Powerup
extends Area3D

signal collected(type: PowerupManager.PowerupType)

@export var powerup_type: PowerupManager.PowerupType

@export var powerup_mesh: Mesh:
	set(value):
		powerup_mesh = value

		if has_node("visual/MeshInstance3D"):
			$visual/MeshInstance3D.mesh = value


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("car"):
		collected.emit(powerup_type)
		queue_free()
