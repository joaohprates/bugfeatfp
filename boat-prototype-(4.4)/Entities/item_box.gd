extends RigidBody2D
class_name PickableItem

var iscol = false
var in_range = false
@onready var item = Global.bank.items['placeholder']._birth()

func _ready() -> void:
	$borda.area_entered.connect(player_touch)
	$borda.area_exited.connect(player_nottouch)
	$Pick_Zone.area_entered.connect(player_on_pickup_zone)
	$Pick_Zone.area_exited.connect(player_off_pickup_zone)

func _physics_process(delta: float) -> void:
	if in_range and Input.is_action_just_pressed("Interact"):
		Global.inventory._add_item(item)
		queue_free()
		
	if iscol:
		linear_damp = 0
		angular_damp = 0
	else:
		linear_damp = 2
		angular_damp = 10
func player_touch(area : Area2D):
	iscol = true
func player_nottouch(area : Area2D):
	iscol = false
func player_on_pickup_zone(area :Area2D):
	in_range = true
func player_off_pickup_zone(area :Area2D):
	in_range = false
