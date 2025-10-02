extends Resource

class_name Quest

@export var q_name : String
@export var description : String
@export var requirements : Array[QuestRequirements]
@export var active : bool
@export var done : bool ##
@export var completed : bool
@export var rewards : QuestReward
@export var acc_text : String
@export var deny_text : String

func _init(name : String, desc : String, req : Array[QuestRequirements], reward : QuestReward) -> void:
	q_name = name
	description = desc 
	requirements = req
	rewards = reward
	done = false
	completed = false
	acc_text = 'thank u'
	deny_text = 'fuck u'

## Verifica se todos os requisitos da quest foram atendidos, e se foram, marca 
##[param done] como [code]true[/code]
func check() -> void:
	for r in requirements:
		if r.actions_todo == r.actions_done:
			done = true
			print(q_name + " done!")
