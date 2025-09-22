extends Node2D

var inventory = preload("res://UI/Inventory.tscn").instantiate()
var inv_on_screen = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory") and !inv_on_screen:
		$CanvasLayer.add_child(inventory)
		inv_on_screen = true
	elif Input.is_action_just_pressed("Inventory") and inv_on_screen:
		$CanvasLayer.remove_child($CanvasLayer.get_node('Inventory'))
		inv_on_screen = false
