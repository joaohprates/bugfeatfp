extends Node
class_name PauseCalculator

var pauses := [] as Array
const PAUSE_PATTERN = "({p=\\d([.]\\d+)?[}])"
var _pause_regex = RegEx.new()

const FLOAT_PATTERN := "\\d+\\.\\d+"
const BBCODE_I_PATTERN := "\\[(?!\\/)(.*?)\\]"
const BBCODE_E_PATTERN := "\\[\\/(.*?)\\]"

const CUSTOM_TAG_PATTERN := "({(.*?)})"

var _float_regex := RegEx.new()
var _bbcode_i_regex := RegEx.new()
var _bbcode_e_regex := RegEx.new()
var _custom_tag_regex := RegEx.new()

signal pause_requested(duration)

func check_at_position(pos: int) -> void:
	for _pause in pauses:
		if _pause.pause_pos == pos:
			emit_signal("pause_requested", _pause.duration)	

func _adjust_position(pos: int, source_string: String) -> int:
	
	# Previous tags
	var _new_pos := pos
	var _left_of_pos := source_string.left(pos)

	var _all_prev_tags := _custom_tag_regex.search_all(_left_of_pos)
	for _tag_result in _all_prev_tags:
		_new_pos -= _tag_result.get_string().length()
	
	var _all_prev_start_bbcodes := _bbcode_i_regex.search_all(_left_of_pos)
	for _tag_result in _all_prev_start_bbcodes:
		_new_pos -= _tag_result.get_string().length()

	var _all_prev_end_bbcodes := _bbcode_e_regex.search_all(_left_of_pos)
	for _tag_result in _all_prev_end_bbcodes:
		_new_pos -= _tag_result.get_string().length()

	return _new_pos

func _ready() -> void:
	_pause_regex.compile(PAUSE_PATTERN)
	
	_float_regex.compile(FLOAT_PATTERN)
	_bbcode_i_regex.compile(BBCODE_I_PATTERN)
	_bbcode_e_regex.compile(BBCODE_E_PATTERN)
	_custom_tag_regex.compile(CUSTOM_TAG_PATTERN)


func extract_pauses_from_string(source_string : String) -> String:
	pauses = []
	_find_pauses(source_string)
	return _extract_tags(source_string)
	
func _find_pauses(from_string: String) -> void:

	var _found_pauses := _pause_regex.search_all(from_string)

	for _pause_regex_result in _found_pauses:
		var _tag_string := _pause_regex_result.get_string() as String
		var _tag_position := _adjust_position(
			_pause_regex_result.get_start(),
			from_string
		)
		var _pause = Dpause.new(_tag_position, _tag_string)
		pauses.append(_pause)
	
func _extract_tags(from_string: String) -> String:
	return _custom_tag_regex.sub(from_string, "", true)
