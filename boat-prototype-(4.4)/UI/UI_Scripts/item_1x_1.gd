extends Node2D

class_name ItemBlock

var last_pos = Vector2.ZERO
@onready var spot0 = $spot0
@onready var click_zone = $Click_Zone
var mouse_on_top = false
var follow = false
var slot_ready = false
var home_slot = null
var hover_slot = null
var inventory_index
var type 
@onready var counter = $Control/Counter

func _ready() -> void:
	$Icon.texture = load(type.sprite)
	click_zone.input_pickable = false
	last_pos = global_position
	click_zone.mouse_entered.connect(_mouse_entered)
	click_zone.mouse_exited.connect(_mouse_exited)
	spot0.area_entered.connect(spot0_check)
	spot0.area_exited.connect(spot0_leave)
	Signals.update_counter.connect(_counter_update)
	_snap(home_slot)
	Signals.update_counter.emit()
func _process(delta: float) -> void:
	
	if follow == true:
		global_position = get_global_mouse_position()
		top_level = true
	else:
		top_level = false
	if Input.is_action_pressed("l_click"):
		click_zone.input_pickable = false
		if mouse_on_top:
			follow = true
	if Input.is_action_just_released("l_click"):
		click_zone.input_pickable = true
		if follow:
			follow = false
			_landing_check()
	if Input.is_action_just_pressed("r_click") and follow:
		if hover_slot != null and Global.items[inventory_index].units > 1:
			_place_one()
		
func _landing_check():
	if slot_ready and hover_slot.empty:
		_snap(hover_slot)
		print("default snap")
	else:
		if hover_slot != null and hover_slot != home_slot:
			if home_slot != null:
				#home_slot.empty = true
				print('merge')
			Global.inventory._merge(hover_slot.slotted_item, self)
		else:
			_snap(home_slot)
			print('snap')

func _place_one():
	if hover_slot != null and hover_slot.empty:
		Global.items[inventory_index].units -= 1
		Global.items.append(type._birth())
		var new_block = load(type.item_block).instantiate()
		new_block.type = type._birth()
		Global.inventory.add_child(new_block)
		new_block.inventory_index = Global.items.size() - 1
		new_block.home_slot = hover_slot
		new_block._snap(new_block.home_slot)
	elif hover_slot.slotted_item.type.id == type.id \
	and Global.items[hover_slot.slotted_item.inventory_index].units < type.max_stack:
		Global.items[inventory_index].units -= 1
		Global.items[hover_slot.slotted_item.inventory_index].units += 1
	Signals.update_counter.emit()

func switch(item2 : ItemBlock):
	var it1_home = home_slot
	var it2_home = item2.home_slot
	_snap(it2_home)
	item2._snap(it1_home)

func _mouse_entered():
	mouse_on_top = true
	
func _mouse_exited():
	mouse_on_top = false
		
func spot0_check(area : Area2D):
	hover_slot = area.get_parent().get_parent()
	print(hover_slot.empty)
	if hover_slot.empty:
		slot_ready = true

func spot0_leave(area : Area2D):
	slot_ready = false
	hover_slot = null

func _snap(slot : InventorySlot):
	if home_slot != null:
		home_slot.empty = true
	home_slot = slot
	global_position = slot.get_node("MarginContainer/Center").global_position
	home_slot.slotted_item = self
	home_slot.empty = false
	print('i ', self, ' snapped to ', home_slot)

func _unsnap():
	if home_slot != null:
		home_slot.empty = true

func _counter_update():
	counter.text = str(Global.items[inventory_index].units)

func _exit_tree() -> void:
	print('i died')
