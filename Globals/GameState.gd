extends Node


enum Objectives {
	none,
	collect_items
}

var curr_objective : Objectives = Objectives.none
var collecting_done := false
var is_paused := false


var is_normal := false
var is_speedrun := false
