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
	if dials.quests['first'].done and !dials.quests['first'].completed:
		fala = dials.falas['first_comp']
		dials.quests['first'].completed = true
	elif dials.quests['first'].completed:
		fala = dials.falas['test']
	elif !dials.quests['first'].done and dials.quests['first'].active :
		fala = dials.falas['first_acc']
	if Global.player.active == true:
		Global.StartDialogue(fala.duplicate(), nome)
		Global.player.active = false

func change_line(line : Array):
	fala = line
