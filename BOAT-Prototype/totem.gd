extends Interactable

@onready var exp = preload("res://Entities/exp.tscn")

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if InRange and Input.is_action_just_pressed("Interact"):
		Global.player.HUD.add_child(load("res://Entities/exp.tscn").instantiate())
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	InRange = true
