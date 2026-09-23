class_name PowerupManager
extends Node

signal powerup_collected(type: PowerupType)

enum PowerupType {
	speedBoost,
	jump
}

@export var powerups: Array[Powerup]
@onready var dialogue_ui: Control = $"../../ui/dialogueUI"



func _ready() -> void:
	for powerup in powerups:
		powerup.collected.connect(_on_powerup_collected)


func _on_powerup_collected(type: PowerupType) -> void:
	# Tell the player
	powerup_collected.emit(type)

	# Show information to the player
	match type:
		PowerupType.speedBoost:
			dialogue_ui.show_msg(
				"SPEED BOOST\nHold %s to boost!" % get_action_key("boost"),
				3.0
			)

		PowerupType.jump:
			dialogue_ui.show_msg(
				"JUMP BOOST\nPress %s to jump!" % get_action_key("jump"),
				3.0
			)


func get_action_key(action_name: String) -> String:
	var events := InputMap.action_get_events(action_name)

	for event in events:
		if event is InputEventKey:
			return event.as_text()
		if event is InputEventMouseButton:
			return event.as_text()

	return "?"
