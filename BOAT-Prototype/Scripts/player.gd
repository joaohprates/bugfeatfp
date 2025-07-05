extends CharacterBody2D

@onready var HUD = get_node("CanvasLayer")
@onready var UI = get_node("CanvasLayer/UI")
@export var mspeed = 100
var speed = 0
var dir = Vector2.ZERO
var accel = 1750
var active = true


func _ready() -> void:
	Global.player = self
	Global.Tela_Player = UI
func _physics_process(delta: float) -> void:
	if active:
		move(delta)
func _process(delta: float) -> void:
	inputs()
func move(delta):
	if dir != Vector2.ZERO and speed < mspeed:
		speed += accel * delta
	else:
		speed -= accel * delta
	if dir == Vector2.ZERO:
		speed = 0
	velocity = dir.normalized() * speed
	move_and_slide()
	
func inputs():
	dir.x = Input.get_action_raw_strength("RIGHT") - Input.get_action_raw_strength("LEFT")
	dir.y = Input.get_action_raw_strength("DOWN") - Input.get_action_raw_strength("UP")
