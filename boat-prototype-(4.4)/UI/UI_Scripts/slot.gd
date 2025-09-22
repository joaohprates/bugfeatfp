extends Control

class_name InventorySlot

@export var empty = true
var slotted_item = null
@onready var center = get_node("MarginContainer/Center")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if empty:
		slotted_item = null
		$MarginContainer/Center.monitorable = true
		$MarginContainer/Center/CollisionShape2D.debug_color = Color("00a4546b")
	else:
		$MarginContainer/Center/CollisionShape2D.debug_color = Color("fe00346b")
		#$MarginContainer/Center.monitorable = false
