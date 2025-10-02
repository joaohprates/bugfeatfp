extends Node

var quest_box = preload("res://UI/Quest Box.tscn").instantiate()
var quest_window = preload("res://UI/QuestWindow.tscn").instantiate()
var active_quests : Array = []

func _ready() -> void:
	Signals.action.connect(quest_update)
	print("Quest Manager Loaded ")

func  start_quest(quest : Quest) -> void:
	active_quests.append(quest)
	quest.active = true
	print(quest.q_name + ' Is now  active')

## Atualiza o estado das quests ativas
func quest_update(action) -> void:
	for q in active_quests:
		for r in q.requirements:
			if r.type.equal(action):
				r.actions_done += 1
		q.check()

func inv_check():
	pass

## Marca [param quest] como entregue e a remoe da lista de quests ativas
func finish_quest(quest : Quest):
	quest.completed = true
	active_quests.erase(quest)
	print('reward given')

func quest_pop_up(quest : Quest):
	print(quest)
	Global.Tela_Player.add_child(quest_box)
	quest_box.quest = quest
	quest_box._update()
	print(quest_box.quest)
