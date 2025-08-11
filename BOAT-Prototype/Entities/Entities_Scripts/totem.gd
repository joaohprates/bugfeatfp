extends Interactable

@onready var exp = preload("res://UI/Expedition.tscn")

func _ready() -> void:
	$Area2D.area_exited.connect(_on_area_exit)
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
func _process(delta: float) -> void:
	if InRange and Input.is_action_just_pressed("Interact"):
		Global.player.UI.add_child(exp.instantiate())
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	InRange = true
func _on_area_exit(area : Area2D):
	InRange = false
