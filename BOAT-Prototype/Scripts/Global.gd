extends Node

@onready var bank = preload("res://Resources/ItemBank.tres")
@onready var inventory = preload('res://UI/Inventory.tscn').instantiate()

var player
var player_boat
var Tela_Player
var Tela_Boat
var prox_cena
var items = []

func _ready() -> void:
	bank.script = load("res://Resources/ItemBank.gd")
	print('Globals Loaded')

## Muda a cena atual para a de [param path]
func mudar_cena(path):
	prox_cena = path
	get_tree().change_scene_to_file("res://UI/Load_Screen.tscn")

#Dialogo ----------------------------------------------------------------------

var dialog_manager
var dialog_box = preload("res://UI/dialog_box.tscn").instantiate()
var dialog_lst = ['']
var emit_name = ''

## Inicia um dialogo com as falas de [param dialogue] sob o nome [param emitter]
func StartDialogue(dialogue : Array, emitter : String):
	print('Dialogue Started')
	dialog_lst = dialogue.duplicate()
	emit_name = emitter
	player.UI.add_child(dialog_box)
	dialog_box.update_message()

## Finaliza o dialogo atual
func EndDialogue():
	print('Dialogue Ended')
	dialog_box.current_message = -1
	player.active = true
