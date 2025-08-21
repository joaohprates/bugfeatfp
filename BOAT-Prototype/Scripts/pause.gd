extends CanvasLayer
# Inicialização
func _ready() -> void:
	visible = false
# ESC
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_on_voltar_pressed()
		else:
			visible = true
			get_tree().paused = true
# Voltar
func _on_voltar_pressed() -> void:
	get_tree().paused = false
	visible = false
# Sair
func _on_sair_pressed() -> void:
	get_tree().quit()
