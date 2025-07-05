extends CharacterBody2D

var speed = 0
var max_speed = 100
var accel = 0.75
var deaccel = 0.75
var t_speed = 0.005
var max_t_speed = 0.005
var t_accel = 0.0004
var t_deaccel = 0.0002
@onready var mk = get_node("Mark")
var dir = Vector2.ZERO
var mkp
var tgt = Vector2.ZERO
var isturn = false
var anchored = false

func _ready():
	Global.player_boat = self
	mk = get_node("Mark")
	print(mk.global_position)
	tgt = Vector2(global_position.x, global_position.y - 2)

func _process(delta: float) -> void:
	Inputs()
	
func _physics_process(delta: float) -> void:
	move()
	
func move():
	var pos = global_position
	mkp = get_node("Mark").global_position
	dir = mkp - pos
	velocity = dir * speed
	move_and_slide()
	mk.global_rotation = mkp.angle_to_point(tgt) + deg_to_rad(90)
	if anchored:
		if speed > 0: 
			speed -= deaccel
		else: 
			speed = 0
		if t_speed > 0 :
			t_speed -= t_deaccel
		else:
			t_speed = 0
	if !anchored:
		if speed < max_speed: 
			speed += accel
		else: 
			speed = max_speed
		if abs(mk.rotation_degrees) < 1:
			isturn = false
		if t_speed <= max_t_speed:
			t_speed += 0.0004
		else:
			t_speed = max_t_speed
	if isturn:
		if snapped(mk.rotation_degrees, 0.01) > 1:
			rotate(t_speed)
		else:
			rotate(-t_speed)
	print(t_speed)

func Inputs():
	if Input.is_action_just_pressed("Anchor"):
		anchored = !anchored
	if Input.is_action_just_pressed('r_click') or  Input.is_action_pressed("r_click"):
		tgt = get_global_mouse_position()
		print(rad_to_deg(mk.rotation))
		if !isturn:
			t_speed = 0
			isturn = true
