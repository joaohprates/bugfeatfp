extends NPC

<<<<<<< Updated upstream:BOAT-Prototype/UI/UI_Scripts/base_npc.gd
@export var dials = preload("res://Entities/JohnGodotData.tres")
=======
var dials = preload("res://Entities/Entities_Scripts/JohnGodotData.tres")
var dial_script = "res://Entities/Entities_Scripts/JohnGodotDial.gd"
>>>>>>> Stashed changes:boat-prototype-(4.4)/Entities/Entities_Scripts/base_npc.gd
var nome = "John Godot"
var dialogues = {'test' : ['This is a test dialogue.{p=1.0} That was a pause test', 'Good morning.{p=0.5} [wave]Good Evening[/wave].{p=0.5} And Good Night', '[shake]Fuck you[/shake]']}
var fala = dials.falas['greet']

func _ready() -> void:
	dials.script = load(dial_script)
	super()

func _on_interact():
	if Global.player.active == true:
		Global.StartDialogue(fala, nome)
		Global.player.active = false
	
