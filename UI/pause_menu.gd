extends Control


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause() -> void:
	GameState.is_paused = !GameState.is_paused
	get_tree().paused = GameState.is_paused
	visible = GameState.is_paused
	print("PAUSED:", get_tree().paused)
	if GameState.is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _on_continue_pressed() -> void:
	GameState.is_paused = false
	get_tree().paused = false
	hide()


func _on_quit_pressed() -> void:
	get_tree().quit()
