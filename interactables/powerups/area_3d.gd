extends Area3D

@export var powerup_mesh: Mesh

@onready var mesh_instance: MeshInstance3D = $mesh


func _ready() -> void:
	mesh_instance.mesh = powerup_mesh
