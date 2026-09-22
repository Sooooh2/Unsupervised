extends Node

@onready var collectible_manager: Node = $"../CollectibleManager"
@onready var objective_ui: Control = $"../../ui/objectiveUI"
@onready var dialogue_ui: Control = $"../../ui/dialogueUI"
@onready var cheese: Node3D = $"../../interactables/cheese"


var curr_obj_index := 0
var collectibles: Array[Node3D] = []




func start_game() -> void:
	print("wsdg")
	objective_ui.set_objective("GO COLLECT THINGS!")

	await StopWatch.start_countdown(3.0)
	GameState.curr_objective = GameState.Objectives.collect_items
	StopWatch.start_timer()
	collectible_manager.start_collecting()


func stop_game() -> void:
		objective_ui.hide_objective()
		print(GameState.curr_objective)
