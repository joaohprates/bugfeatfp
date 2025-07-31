extends Node
class_name NPC

@onready var IZone = $InteractZone as Area2D

var InRange = false

signal _interacted()

func _ready() -> void:
	IZone.area_entered.connect(_entered_zone)
	IZone.area_exited.connect(_exited_zone)
	_interacted.connect(_on_interact)
	
func _process(delta: float) -> void:
	if Global.player.active == true:
		if InRange and Input.is_action_just_pressed("Interact"):
			emit_signal('_interacted')

func _entered_zone(area : Area2D):
	InRange = true
func _exited_zone(area : Area2D):
	InRange = false
func _on_interact():
	pass
