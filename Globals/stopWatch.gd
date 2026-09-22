extends Node

signal countdown_changed(text: String)

var elapsed := 0.0
var running := false
var counting_down := false

func start_timer() -> void:
	elapsed = 0.0
	running = true


func _process(delta: float) -> void:
	if running:
		elapsed += delta


func stop_timer() -> void:
	running = false


func start_countdown(seconds: int) -> void:
	counting_down = true

	for i in range(seconds, 0, -1):
		countdown_changed.emit(str(i))
		await get_tree().create_timer(1.0).timeout

	countdown_changed.emit("GO!")
	await get_tree().create_timer(0.5).timeout

	counting_down = false
	countdown_changed.emit("")
