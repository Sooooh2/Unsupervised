extends Node


enum Objectives {
	none,
	get_cheese
}

var curr_objective : Objectives = Objectives.none
var cheese_found := false
var is_paused := false
