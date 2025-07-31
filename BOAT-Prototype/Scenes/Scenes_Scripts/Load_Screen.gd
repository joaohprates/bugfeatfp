extends Control

signal scene_loaded(path)

@onready var path = Global.prox_cena
@onready var bar = get_node("MarginContainer/VBoxContainer/ProgressBar")
var progress_val



func _ready() -> void:
	_load(path)
	
func _load(path_to_load):
	ResourceLoader.load_threaded_request(path_to_load)
	print('loaded')

func _process(delta: float) -> void:
	if not path:
		return
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(path, progress)
	print(status)
	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
		progress_val = progress[0]*100
		bar.value = move_toward(bar.value, progress_val, delta * 20)
		
	if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		bar.value = move_toward(bar.value, 100.0, delta * 150)
		
		if bar.value >= 99.0:
			scene_loaded.emit(path)
	


func _on_scene_loaded(path: Variant) -> void:
	get_tree().change_scene_to_file(path)
