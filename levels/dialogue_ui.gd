extends Control

@onready var msg: RichTextLabel = $msg



func show_msg(text: String) -> void:
	msg.text = text


func hide_msg() -> void:
	hide()
