extends Node2D
class_name DialogManager

var dialog_box = preload("res://UI/dialog_box.tscn").instantiate()
var dialog_lst = ['']

signal StartDialogue(dialogue : Array[String])
signal EndDialogue()

func _ready() -> void:
	Global.dialog_manager = self
