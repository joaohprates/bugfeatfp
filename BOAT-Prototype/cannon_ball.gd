extends Area2D
var pos : Vector2
var rota : float
var dir : float
var velocidade = 1200

func _ready():
	global_position = pos
	global_rotation = rota
	
	connect("body_entered", Callable(self, "_on_cannonBall_body_entered"))
	
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(queue_free)
	add_child(timer)
	
	
func _on_cannonBall_body_entered(_body):
	queue_free()
	
func _physics_process(delta):
	position += Vector2(velocidade * delta, 0).rotated(dir)

	
