extends Node

var player
var player_boat
var Tela_Player
var prox_cena

func _ready() -> void:
	print('Globals Loaded')

func mudar_cena(path):
	prox_cena = path
	get_tree().change_scene_to_file("res://UI/Load_Screen.tscn")

#Dialogo ----------------------------------------------------------------------
var dialog_manager
var dialog_box = preload("res://UI/dialog_box.tscn").instantiate()
var dialog_lst = ['']
var emit_name = ''

func StartDialogue(dialogue, emitter):
	print('Dialogue Started')
	dialog_lst = dialogue
	emit_name = emitter
	player.UI.add_child(dialog_box)
	dialog_box.update_message()
	
func EndDialogue():
	print('Dialogue Ended')
	dialog_box.current_message = -1
	player.active = true
