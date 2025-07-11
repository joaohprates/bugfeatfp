extends CharacterBody2D

var speed = 100
var max_speed = 100
var accel = 0.75
var deaccel = 0.75
var t_speed = 0.005
var max_t_speed = 0.005
var t_accel = 0.0004
var t_deaccel = 0.0002
var dir = Vector2.ZERO
var isturn = false
var anchored = false
enum State{IDLE, COMBAT}
var state = State.IDLE
var too_close = false
var too_far = false
var last_dir = 0
var new_dir = 0

@onready var det_zone = get_node("Detec_Area")
@onready var mk = get_node("Mark")
@onready var helm = get_node("Helm")

func _ready() -> void:
	print(helm)
	det_zone.area_entered.connect(_player_a_vista)
	$Inner_Combat_Zone.area_entered.connect(_p_on_ic_zone)
	$Inner_Combat_Zone.area_exited.connect(_p_out_ic_zone)
	$Outer_Combat_Zone.area_entered.connect(_p_in_oc_zone)
	$Outer_Combat_Zone.area_exited.connect(_p_out_oc_zone)
	

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if state == State.COMBAT:
		_attack()

func _set_nodes():
	pass

func _attack():
	_move()
	helm.global_rotation = helm.global_position.angle_to_point(Global.player_boat.global_position) + deg_to_rad(90)
	new_dir = last_dir
	if snapped(rad_to_deg(helm.rotation), 0.01) > 0:
		if too_close:
			_turn(-1)
			last_dir = 0
		elif too_far:
			_turn(1)
		elif snapped(rad_to_deg(helm.rotation), 0.1) > 90:
			_turn(1)
			last_dir = 1
	elif snapped(rad_to_deg(helm.rotation), 0.1) < 0:
		if too_close:
			_turn(1)
			last_dir = 2
		elif too_far:
			_turn(-1)
		elif snapped(rad_to_deg(helm.rotation), 0.1) < -90:
			_turn(-1)
			last_dir = 3
	elif snapped(rad_to_deg(helm.rotation), 0.1) == 0:
		_turn(0)
		last_dir = 5
	if new_dir != last_dir:
		t_speed = 0
func _move():
	speed += accel
	speed = clamp(speed, 0, max_speed)
	dir =  mk.global_position - global_position
	velocity = dir * speed
	move_and_slide()

func _turn(l):
	'''
	se *l* é 1, gira o barco para a direita, se for -1 gira para a esquerda
	'''
	t_speed += t_accel
	t_speed = clamp(t_speed, 0, max_t_speed)
	rotate(t_speed * l)
	
func _player_a_vista (area: Area2D):
	state = State.COMBAT
	
func _p_on_ic_zone(area : Area2D):
	too_close = true
func _p_out_ic_zone(area : Area2D):
	too_close = false
func _p_in_oc_zone(area : Area2D):
	too_far = false
	print('inzone')
func _p_out_oc_zone(area : Area2D):
	too_far = true
	print('outofzone')
