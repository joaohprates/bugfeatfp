extends Node2D

@onready var pause_menu = $Pause
var paused = false

func input_menu(delta):
	if Input.is_action_pressed("ui_cancel"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
