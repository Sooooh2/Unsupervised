extends Node

signal item_collected

@export var collectibles: Array[Node3D]
@onready var dialogue_ui: Control = $"../../ui/dialogueUI"
@onready var objective_manager: Node = $"../ObjectiveManager"

var cur_index := 0


func start_collecting() -> void:
	cur_index = 0
	GameState.curr_objective = GameState.Objectives.collect_items
	for thing in collectibles:
		thing.collected.connect(_on_thing_collected.bind(thing))


func _on_thing_collected(thing: Node3D) -> void:
	cur_index += 1
	item_collected.emit()
	
	if cur_index >= collectibles.size():
		_finished_collecting()


func _finished_collecting() -> void:
	objective_manager.stop_game()
	StopWatch.running = false
	GameState.collecting_done = true
	dialogue_ui.show_msg("collected in  %.2f" % StopWatch.elapsed, 2.0)
