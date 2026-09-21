extends Node


var elapsed := 0.0
var running := false


func start_timer() -> void:
	elapsed = 0.0
	running = true


func _process(delta: float) -> void:
	if running:
		elapsed += delta


func stop_timer() -> void:
	running = false
