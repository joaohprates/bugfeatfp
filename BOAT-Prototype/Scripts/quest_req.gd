extends Resource

class_name QuestRequirements

var type 
var instructions : String
@export var actions_todo : int
@export var actions_done : int

func _init(typ, todo : int, done : int, inst : String) -> void:
	type = typ
	actions_todo = todo
	actions_done = done
	instructions = inst
	
