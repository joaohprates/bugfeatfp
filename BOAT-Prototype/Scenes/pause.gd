extends CanvasLayer


func _ready():
	visible = false

func _process(delta):
	pass
	
func _on_voltar_pressed():
	get_tree().paused = false
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_on_voltar_pressed()
		else:
			visible = true
			get_tree().paused = true
		
	
func _on_sair_pressed():
	get_tree().quit()
