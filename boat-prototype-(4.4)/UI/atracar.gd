extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		Global.mudar_cena("res://Scenes/ilha_2.tscn")
