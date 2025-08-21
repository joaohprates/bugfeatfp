extends Boat

class_name Enemy

enum State{IDLE, COMBAT}
var state = State.IDLE
var too_close = false
var too_far = false

var new_dir = 0

var foe_on_r_aim = false
var foe_on_l_aim = false

@onready var det_zone = get_node("Detec_Area")
@onready var mk = get_node("Mark")
@onready var helm = get_node("Helm")

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
	hp = 6

func _ready() -> void:
	det_zone.area_entered.connect(_player_a_vista)
	$Inner_Combat_Zone.area_entered.connect(_p_on_ic_zone)
	$Inner_Combat_Zone.area_exited.connect(_p_out_ic_zone)
	$Outer_Combat_Zone.area_entered.connect(_p_in_oc_zone)
	$Outer_Combat_Zone.area_exited.connect(_p_out_oc_zone)
	_initialize_var()
	super()

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if state == State.COMBAT:
		_attack()

func _set_nodes():
	pass

func steer():
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

func _attack():
	_move()
	helm.global_rotation = helm.global_position.angle_to_point(Global.player_boat.global_position) + deg_to_rad(90)
	new_dir = last_dir
	steer()
		
	if foe_on_r_aim and can_shoot_right:
		rightFire()
	if foe_on_l_aim and can_shoot_left:
		leftFire()
	if $LeftAim.is_colliding() and can_shoot_left:
		leftFire()
	if $RightAim.is_colliding() and can_shoot_right:
		rightFire()
func _move():
	sail(1)
	dir =  mk.global_position - global_position
	velocity = dir * speed
	move_and_slide()
	
func _player_a_vista (area: Area2D):
	state = State.COMBAT
	
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

func _start_shoot_cooldown(side: String):
	var timer = Timer.new()
	timer.wait_time = shoot_cooldown
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(func():
		if side == "left":
			can_shoot_left = true
		elif side == "right":
			can_shoot_right = true
		timer.queue_free()
	)
	add_child(timer)
	
func got_killed():
	queue_free()

func _p_on_ic_zone(area : Area2D):
	too_close = true
func _p_out_ic_zone(area : Area2D):
	too_close = false
func _p_in_oc_zone(area : Area2D):
	too_far = false
func _p_out_oc_zone(area : Area2D):
	too_far = true
