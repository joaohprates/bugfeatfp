extends Control

@onready var quest : Quest = Quest.new('test', 'this is a test description for a test quest',\
 [QuestRequirements.new(Global.bank.items['placeholder'], 10, 0, 'Get McGuffins'),\
QuestRequirements.new(Global.bank.items['placeholder'], 5, 0, 'Do some shit')], QuestReward.new(69, 420, []))
@onready var Q_Name = $Panel/MarginContainer/VBoxContainer/QuestName
@onready var Descript = $Panel/MarginContainer/VBoxContainer/Description
@onready var Requirements = $Panel/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/Requirements
@onready var Reward = $Panel/MarginContainer/VBoxContainer/HBoxContainer/Rewards
@onready var req_block = preload("res://UI/Quest_Req_Block.tscn").instantiate()

func _ready() -> void:
	$Panel/MarginContainer/MarginContainer/HBoxContainer/Accept.pressed.connect(quest_accept)
	$Panel/MarginContainer/MarginContainer/HBoxContainer/Deny.pressed.connect(quest_deny)
func _update():
	Q_Name.text = quest.q_name
	Descript.text = quest.description
	Reward.text = quest.rewards.text_form()
	for r in quest.requirements:
		var req = req_block.duplicate()
		Requirements.add_child(req)
		req.get_node('Panel/HBoxContainer/Instructions').text = r.instructions
		req.get_node('Panel/HBoxContainer/TODO_DONE').text = str(r.actions_done) + ' / ' + str(r.actions_todo)

func quest_accept():
	Global.dialog_box.popup = false
	QuestManager.start_quest(quest)
	if Global.dialog_box.current_message != Global.dialog_box.dialog.size() - 1:
		Global.dialog_box.update_message()
	get_parent().remove_child(self)
	

func quest_deny():
	Global.dialog_box.popup = false
	if Global.dialog_box.current_message != Global.dialog_box.dialog.size() - 1:
		Global.dialog_box.update_message()
	get_parent().remove_child(self)
	
