extends Interactable

@onready var atracar_scene = preload("res://UI/atracar.tscn")
var atracar_instance: Node = null

func _ready() -> void:
	$Area2D.area_exited.connect(_on_area_exit)
	$Area2D.area_entered.connect(_on_area_2d_area_entered)

func _on_area_2d_area_entered(area: Area2D) -> void:
	InRange = true
	if Global.player_boat and Global.Tela_Boat:
		if atracar_instance == null:
			atracar_instance = atracar_scene.instantiate()
			atracar_instance.name = "AtracarUI"
			Global.Tela_Boat.add_child(atracar_instance)

func _on_area_exit(area : Area2D) -> void:
	InRange = false
	if atracar_instance and atracar_instance.is_inside_tree():
		atracar_instance.queue_free()
		atracar_instance = null
