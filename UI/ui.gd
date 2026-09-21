extends Control


@onready var timer: Label = $Timer


func _process(delta: float) -> void:
	timer.text = "%.2f" % StopWatch.elapsed
	
	if GameState.cheese_found:
		hide()
