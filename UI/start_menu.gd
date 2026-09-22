extends Control


func _ready() -> void:
	pass



func _on_quit_pressed() -> void:
	get_tree().quit()
	


func _on_normal_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/high_level_3_deg.tscn")
	GameState.is_normal = true


func _on_speedrun_mode_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/high_level_3_deg.tscn")
	GameState.is_speedrun = true
