extends Node


func _ready() -> void:
	if GameState.is_normal:
		normal_mode()
	if GameState.is_speedrun:
		speedrun_mode()


func normal_mode() -> void:
	pass

func speedrun_mode() -> void:
	pass
