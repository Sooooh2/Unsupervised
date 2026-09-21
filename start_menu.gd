extends Control


func _ready() -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/high_level_3_deg.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
	
