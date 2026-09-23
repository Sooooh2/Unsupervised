extends Control

@onready var msg: RichTextLabel = $msg



func show_msg(text: String, dur: float) -> void:
	msg.text = text
	show()
	await get_tree().create_timer(dur).timeout
	hide_msg()


func show_instruction(text: String) -> void:
	msg.text = text
	show()


func hide_msg() -> void:
	hide()
