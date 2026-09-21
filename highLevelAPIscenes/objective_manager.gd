extends Node

@onready var objective_manager: Control = $"../objectiveUI"
@onready var dialogue_manager: Control = $"../dialogueUI"
@onready var cheese: Node3D = $"../cheese"


func _ready() -> void:
	cheese.cheese_collected.connect(_on_cheese_collected)


func start_game() -> void:
	print("wsdg")
	GameState.curr_objective = GameState.Objectives.get_cheese
	StopWatch.start_timer()
	
	objective_manager.set_objective("GO FIND CHEESE!")


func _on_cheese_collected() -> void:
	if GameState.curr_objective != GameState.Objectives.get_cheese:
		return 
	GameState.cheese_found = true
	StopWatch.stop_timer()
	var time_taken = StopWatch.elapsed
	dialogue_manager.show_msg("you found it ! in under %.2f" % time_taken)
	print("asbfdwdfsbgvfdawadfsgg")
	GameState.curr_objective = GameState.Objectives.none
