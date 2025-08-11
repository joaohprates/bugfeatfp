extends Boat

@onready var helm
var mkp
var tgt = Vector2.ZERO

func _initialize_var():
	speed = 0
	max_speed = 100
	accel = 0.75
	deaccel = 0.75
	t_speed = 0.005
	max_t_speed = 0.005
	t_accel = 0.0004
	t_deaccel = 0.0002
	last_dir = 0
	dir = Vector2.ZERO
	isturn = false
	anchored = false
	can_shoot_left = true
	can_shoot_right = true
	shoot_cooldown = 0.5
	hp = 1000000

func _ready():
	Global.player_boat = self
	_initialize_var()
	helm = get_node("Helm")
	tgt = Vector2(global_position.x, global_position.y - 2)
	super()

func _process(_delta: float) -> void:
	Inputs()

func leftFire():
	if not can_shoot_left:
		return
	can_shoot_left = false
	
	var left_shoot_points = [$Left_Shoot, $Left_Shoot2, $Left_Shoot3]
	
	for lpoint in left_shoot_points:
		var shoot = cannonBall.instantiate()
		shoot.dir = rotation + PI
		shoot.pos = lpoint.global_position
		shoot.rota = global_rotation + PI
		get_parent().add_child(shoot)
		
	_start_shoot_cooldown("left")
	
func rightFire():
	if not can_shoot_right:
		return
	can_shoot_right = false
	
	var right_shoot_points = [$Right_Shoot, $Right_Shoot2, $Right_Shoot3]
	
	for rpoint in right_shoot_points:
		var shoot = cannonBall.instantiate()
		shoot.dir = rotation
		shoot.pos = rpoint.global_position
		shoot.rota = global_rotation
		get_parent().add_child(shoot)
		
	_start_shoot_cooldown("right")
	

func move():
	var pos = global_position
	mkp = get_node("Helm").global_position
	dir = mkp - pos
	velocity = dir * speed
	move_and_slide()
	helm.global_rotation = mkp.angle_to_point(tgt) + deg_to_rad(90)
	if anchored:
		sail(0)
		if t_speed > 0 :
			t_speed -= t_deaccel
			if snapped(helm.rotation_degrees, 0.01) > 1:
				rotate(t_speed)
			else:
				rotate(-t_speed)
		else:
			t_speed = 0
	if !anchored:
		sail(1)
		if abs(helm.rotation_degrees) < 1:
			isturn = false
		if isturn:
			if snapped(helm.rotation_degrees, 0.01) > 1:
				_turn(1)
			else:
				_turn(-1)
	
func Inputs():
	if Input.is_action_just_pressed("Anchor"):
		anchored = !anchored
	if Input.is_action_just_pressed('r_click') or  Input.is_action_pressed("r_click"):
		tgt = get_global_mouse_position()
		if (snapped(helm.rotation_degrees, 0.01) / abs(snapped(helm.rotation_degrees, 0.01))) != last_dir:
			t_speed = 0
		last_dir = (snapped(helm.rotation_degrees, 0.01) / abs(snapped(helm.rotation_degrees, 0.01)))
		if !isturn:
			t_speed = 0
			isturn = true
	if Input.is_action_just_pressed("RIGHT_SHOOT"):
		rightFire()
	if Input.is_action_just_pressed("LEFT_SHOOT"):
		leftFire()
	move()
	
	
