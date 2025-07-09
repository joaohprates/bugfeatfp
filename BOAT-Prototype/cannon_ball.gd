extends CharacterBody2D
var pos : Vector2
var rota : float
var dir : float
var velocidade = 2000





func _ready():
	global_position = pos
	global_rotation = rota
	
func _physics_process(delta):
	velocity = Vector2(velocidade, 0).rotated(dir)
	move_and_slide()
	
