extends NPC

var dials = preload("res://Resources/NPCs/JohnGodotData.tres")
var dial_script = "res://Resources/NPCs/JohnGodotDial.gd"
var nome = "John Godot"
var dialogues = {'test' : ['This is a test dialogue.{p=1.0} That was a pause test', 'Good morning.{p=0.5} [wave]Good Evening[/wave].{p=0.5} And Good Night', '[shake]Fuck you[/shake]']}
var fala : Array

func _ready() -> void:
	dials.script = load(dial_script)
	fala = dials.falas['greet']
	print(fala)
	super()

func _on_interact():
	if Global.player.active == true:
		Global.StartDialogue(fala, nome)
		Global.player.active = false

func change_line(line : Array):
	fala = line
