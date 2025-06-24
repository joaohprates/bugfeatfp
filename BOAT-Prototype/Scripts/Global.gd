extends Node

var player
var player_boat
var Tela_Player
var prox_cena

func mudar_cena(path):
	prox_cena = path
	get_tree().change_scene_to_file("res://UI/Load_Screen.tscn")
