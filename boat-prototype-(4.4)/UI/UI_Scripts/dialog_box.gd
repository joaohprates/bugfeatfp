extends Control
class_name Dialogue

@onready var content = get_node("MarginContainer/VBoxContainer/Panel/MarginContainer/Content")
@onready var TypeTimer = get_node("TypeTimer")
@onready var _calc = get_node("PauseCalculator")
@onready var dialog = Global.dialog_lst
@onready var nametag = $MarginContainer/VBoxContainer/PanelContainer/Name

var speaking = false
var current_message = -1

func _ready() -> void:
	print(nametag)
	nametag.text = Global.emit_name
	Global.dialog_box = self
	$PauseCalculator.pause_requested.connect(_on_pause_requested)
	$PauseTimer.timeout.connect(_on_pause_timeout)
	TypeTimer.timeout.connect(TypeTimer_timeout)
	content.visible_characters = 0
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if !speaking and current_message == dialog.size() - 1:
			get_parent().remove_child(self)
			Global.EndDialogue()
		else:
			update_message()

func update_message():
	if speaking:
		speaking = false
		TypeTimer.stop()
		content.visible_characters = content.text.length()

	else:
		speaking = true
		current_message += 1
		content.visible_characters = 0
		content.text = _calc.extract_pauses_from_string(dialog[current_message])
		TypeTimer.start()

func TypeTimer_timeout():
	$PauseCalculator.check_at_position(content.visible_characters)
	if content.visible_characters < content.text.length() and content.visible_ratio < 1:
		$AnimationPlayer.play("Speaker_Speak")
		content.visible_characters += 1
	else:
		TypeTimer.stop()
		speaking = false


func _on_pause_requested(duration):
	TypeTimer.stop()
	$PauseTimer.wait_time = duration
	$PauseTimer.start()
func _on_pause_timeout():
	TypeTimer.start()
