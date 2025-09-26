extends Node

signal update_counter

signal item_obtained(item : Item)

signal action(act)

func _ready() -> void:
	print('Signals Loaded')
	
