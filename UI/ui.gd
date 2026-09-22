extends Control


@onready var timer: Label = $Timer


func _process(delta: float) -> void:
	if StopWatch.running:
		timer.text = "%.2f" % StopWatch.elapsed
	
	if GameState.collecting_done:
		hide()
