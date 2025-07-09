extends CharacterBody2D

var speed = 100
var max_speed = 100
var accel = 0.75
var deaccel = 0.75
var t_speed = 0.01
var max_t_speed = 0.01
var t_accel = 0.0004
var t_deaccel = 0.0002
var dir = Vector2.ZERO
var isturn = false
var anchored = false
enum State{IDLE, COMBAT}
var state = State.IDLE
var perto_demais = false
var last_dir = 0
var new_dir = 0

@onready var det_zone = get_node("Detec_Area")
@onready var mk = get_node("Mark")
@onready var helm = get_node("Helm")

func _ready() -> void:
	print(helm)
	det_zone.area_entered.connect(_player_a_vista)
	$Combat_Zone.area_entered.connect(_p_on_c_zone)
	$Combat_Zone.area_exited.connect(_p_out_c_zone)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if state == State.COMBAT:
		_attack()

func _set_nodes():
	pass

func _attack():
	_move()
	print(t_speed)
	helm.global_rotation = helm.global_position.angle_to_point(Global.player_boat.global_position) + deg_to_rad(90)
	new_dir = last_dir
	if snapped(rad_to_deg(helm.rotation), 0.01) > 0:
		if perto_demais:
			_turn(-1)
			last_dir = 0
		elif snapped(rad_to_deg(helm.rotation), 0.1) > 90:
			_turn(1)
			last_dir = 1
	elif snapped(rad_to_deg(helm.rotation), 0.1) < 0:
		if perto_demais:
			_turn(1)
			last_dir = 2
		elif snapped(rad_to_deg(helm.rotation), 0.1) < -90:
			_turn(-1)
			last_dir = 3
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
	
func _p_on_c_zone(area : Area2D):
	perto_demais = true
func _p_out_c_zone(area : Area2D):
	perto_demais = false
