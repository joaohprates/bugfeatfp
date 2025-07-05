extends Node2D

class_name Interactable

var InRange = false

func _on_area_entered():
	InRange = true
	print("entrou")
func _on_area_exited():
	InRange = false
	print("saiu")
