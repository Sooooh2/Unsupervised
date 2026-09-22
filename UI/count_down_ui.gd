extends Control

@onready var label: RichTextLabel = $countdown


func _ready() -> void:
	StopWatch.countdown_changed.connect(_on_countdown_changed)
	hide()


func _on_countdown_changed(text: String) -> void:
	if text == "":
		hide()
	else:
		show()
		label.text = text
