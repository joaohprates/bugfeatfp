extends Area2D

# Var fixa
@export var pos: Vector2
@export var rota: float
@export var dir: float

# Var mutável
@export var velocidade: float = 1200.0

# inicialização
func _ready() -> void:
	global_position = pos
	global_rotation = rota

	connect("body_entered", Callable(self, "_on_body_entered"))

	# cooldown
	var timer := Timer.new()
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(queue_free)
	add_child(timer)

# COlisão
func _on_body_entered(_body: Node) -> void:
	queue_free()

# Movimento de bala
func _physics_process(delta: float) -> void:
	position += Vector2(velocidade * delta, 0).rotated(dir)
