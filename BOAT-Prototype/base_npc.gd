extends NPC

var dials = preload("res://JohnGodotData.tres")
var nome = "John Godot"
var dialogues = {'test' : ['This is a test dialogue.{p=1.0} That was a pause test', 'Good morning.{p=0.5} [wave]Good Evening[/wave].{p=0.5} And Good Night', '[shake]Fuck you[/shake]']}
var fala = dials.falas['greet']
func _on_interact():
	if Global.player.active == true:
		Global.StartDialogue(fala, nome)
		Global.player.active = false
	
