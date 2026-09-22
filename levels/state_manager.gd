extends Node


func _ready() -> void:
	if GameState.is_normal:
		normal_mode()
	
	if GameState.is_speedrun:
		speedrun_mode()



func normal_mode() -> void:
	print("asdfgfdsadfgrewaqzxcvhy4ewazxcvbhytre")


func speedrun_mode() -> void:
	print("123456787654321`")
