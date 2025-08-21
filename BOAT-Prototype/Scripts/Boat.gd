extends CharacterBody2D

class_name Boat

var hp

var speed
@export var max_speed : float
var accel
var deaccel

var t_speed
@export var max_t_speed :float
var t_accel
var t_deaccel

var last_dir
var dir = Vector2.ZERO
var isturn = false
var anchored = false

var can_shoot_left = true
var can_shoot_right = true
var shoot_cooldown

@onready var cannonBall = preload("res://Entities/cannonBall.tscn")
@onready var hitbox = $Hitbox

signal EntityDied

func _ready() -> void:
	hitbox.area_entered.connect(got_shot)
	EntityDied.connect(got_killed)
	print('asdfg')

func sail(v : int):
	'''
	se *v* é 1, acelera o barco, se é 0, desacelera
	'''
	if v == 1:
		speed += accel
	elif v == 0:
		speed -= deaccel
	speed = clamp(speed, 0, max_speed)
	velocity = dir * speed
	move_and_slide()
	
func _turn(l):
	'''
	se *l* é 1, gira o barco para a direita, se for -1 gira para a esquerda
	'''
	t_speed += t_accel
	t_speed = clamp(t_speed, 0, max_t_speed)
	rotate(t_speed * l)
	
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

func got_shot(area : Area2D):
	print(area.get_parent().name, " hit")
	hp -= 1
	if hp <= 0:
		emit_signal("EntityDied")
func got_killed():
	pass
