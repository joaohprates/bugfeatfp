extends CharacterBody2D

var speed = 0
@export var max_speed = 100
var accel = 0.75
var deaccel = 0.75
var t_speed = 0.005
@export var max_t_speed = 0.005
var t_accel = 0.0004
var t_deaccel = 0.0002
var last_dir = 0
@onready var mk
var dir = Vector2.ZERO
var mkp
var tgt = Vector2.ZERO
var isturn = false
var anchored = false
var cannonBall = preload("res://Entities/cannonBall.tscn")


func _ready():
	Global.player_boat = self
	mk = get_node("Helm")
	tgt = Vector2(global_position.x, global_position.y - 2)

func _process(delta: float) -> void:
	Inputs()
	
func _physics_process(delta: float) -> void:
	move()
	
func leftFire():
	var shoot = cannonBall.instantiate()
	shoot.dir = rotation
	shoot.pos = $Left_Shoot.global_position
	shoot.rota = global_rotation
	get_parent().add_child(shoot)
func rightFire():
	var shoot = cannonBall.instantiate()
	shoot.dir = rotation + PI
	shoot.pos = $Right_Shoot.global_position
	shoot.rota = global_rotation + PI
	get_parent().add_child(shoot)
	
func move():
	var pos = global_position
	mkp = get_node("Helm").global_position
	dir = mkp - pos
	velocity = dir * speed
	move_and_slide()
	mk.global_rotation = mkp.angle_to_point(tgt) + deg_to_rad(90)
	if anchored:
		speed -= deaccel
		if t_speed > 0 :
			t_speed -= t_deaccel
			if snapped(mk.rotation_degrees, 0.01) > 1:
				rotate(t_speed)
			else:
				rotate(-t_speed)
		else:
			t_speed = 0
	if !anchored:
		speed += accel
		if abs(mk.rotation_degrees) < 1:
			isturn = false
		if isturn:
			if snapped(mk.rotation_degrees, 0.01) > 1:
				_turn(1)
			else:
				_turn(-1)
	speed = clamp(speed, 0, max_speed)

func _turn(l):
	'''
	se *l* é 1, gira o barco para a direita, se for -1 gira para a esquerda
	'''
	t_speed += t_accel
	t_speed = clamp(t_speed, 0, max_t_speed)
	rotate(t_speed * l)
	
func Inputs():
	if Input.is_action_just_pressed("Anchor"):
		anchored = !anchored
	if Input.is_action_just_pressed('r_click') or  Input.is_action_pressed("r_click"):
		tgt = get_global_mouse_position()
		if (snapped(mk.rotation_degrees, 0.01) / abs(snapped(mk.rotation_degrees, 0.01))) != last_dir:
			t_speed = 0
		last_dir = (snapped(mk.rotation_degrees, 0.01) / abs(snapped(mk.rotation_degrees, 0.01)))
		if !isturn:
			t_speed = 0
			isturn = true
	if Input.is_action_just_pressed("LEFT_SHOOT"):
		leftFire()
	if Input.is_action_just_pressed("RIGHT_SHOOT"):
		rightFire()
	
