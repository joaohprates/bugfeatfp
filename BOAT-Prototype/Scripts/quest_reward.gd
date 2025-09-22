extends Resource

class_name QuestReward

@export var gold : int
@export var exp : int
@export var items : Array[Item]

func _init(g : int, xp : int, itens : Array[Item]) -> void:
	gold = g
	exp = xp
	items = itens
	print(itens)

func text_form() -> String:
	var gold_str = ''
	var exp_str = ''
	var items_str = ''
	
	if gold != 0:
		gold_str = str(gold) + ' Gold \n'
	if exp != 0:
		exp_str = str(exp) + ' Experience \n'
	if items != []:
		for i in items:
			items_str = items_str + i.item_name + ' X' + str(i.units) + '\n'
	var full_str = gold_str + exp_str + items_str
	
	return full_str
