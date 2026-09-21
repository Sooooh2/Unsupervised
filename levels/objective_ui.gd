extends Control

@onready var objective: RichTextLabel = $objective

func set_objective(text : String) -> void:
	objective.text = text
