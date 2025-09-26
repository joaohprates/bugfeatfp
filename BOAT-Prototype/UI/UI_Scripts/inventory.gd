extends Control

@onready var grid = $MarginContainer
@onready var bank = preload("res://Resources/ItemBank.tres")
var slots : Array

func _ready() -> void:
	Global.inventory = self
	slots = grid.get_node('OuterGrid/GridContainer').get_children()
	$ItemSpawn.pressed.connect(_spawn_item)
	$ItemSpawn2.pressed.connect(_spawn_item2)

func _process(delta: float) -> void:
	pass
	

func _add_item(item : Item):
	print(item.item_name, ' added')
	var home_slot
	var is_on_inv = false
	var has_space = false
	var block = load(item.item_block).instantiate()
	block.type = item
	for i in Global.items:
		if i.id == item.id and i.units < i.max_stack:
			i.units += 1
			is_on_inv = true
			Signals.update_counter.emit()
			break
	for slot in slots:
		if slot.empty:
			home_slot = slot
			has_space = true
			break
	if has_space and !is_on_inv:
		Global.items.append(item)
		grid.add_child(block)
		block.home_slot = home_slot
		print(home_slot)
		block._snap(home_slot)
		block.inventory_index = Global.items.size() - 1
		Signals.update_counter.emit()
	elif !has_space and !is_on_inv:
		print('No Free Slot')
	Signals.update_counter.emit()
	Signals.item_obtained.emit(item)
	Signals.action.emit(item)


func _merge(item1, item2):
	if item1.type.id == item2.type.id:
		if (Global.items[item1.inventory_index].units + Global.items[item2.inventory_index].units) <= Global.items[item1.inventory_index].max_stack:
			Global.items[item1.inventory_index].units += Global.items[item2.inventory_index].units
			Global.items.erase(item2)
			item2.queue_free()
			print('merged')
		elif (Global.items[item1.inventory_index].units + Global.items[item2.inventory_index].units) > Global.items[item1.inventory_index].max_stack:
			var passed = Global.items[item1.inventory_index].max_stack - Global.items[item1.inventory_index].units
			Global.items[item1.inventory_index].units += passed
			Global.items[item2.inventory_index].units -= passed
			item2._snap(item2.home_slot)
			print('added')
		else:
			print('nada')
	else:
		item2.switch(item1)
		item2._snap(item2.home_slot)
	Signals.update_counter.emit()

func _spawn_item():
	_add_item(Global.bank.items['placeholder']._birth())

func _spawn_item2():
	_add_item(Global.bank.items['other']._birth())
