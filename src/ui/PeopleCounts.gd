extends VBoxContainer

onready var _stranded = $Stranded
onready var _in_peril = $InPeril
onready var _on_board = $OnBoard
onready var _safe = $Safe
onready var _died = $Died


var _stranded_count = 0
var _peril_count = 0

var _state = preload("res://src/GameState.tres")
var _first = true


func _ready():
	_state.connect("counts_updated", self, "_update_counts")
	_update_counts()


func _process(_delta):
	if _state.people:
		var stranded = 0
		var in_peril = 0
		for person in _state.people.get_children():
			if person.in_peril():
				in_peril += 1
			else:
				stranded += 1

				
		if stranded != _stranded_count or _first:
			var p_template = "[color=#124e89]Stranded: %s[/color]"
			_stranded.bbcode_text = p_template % stranded
			_stranded.punch()
			_stranded_count = stranded

		if in_peril != _peril_count or _first:
			var i_template = "[color=#e43b44]In Peril: %s[/color]"
			_in_peril.bbcode_text = i_template % in_peril
			_in_peril.punch()
			_peril_count = in_peril

		_first = false


func _update_counts():
	var b_template = "[color=#0099db]On Board: %s[/color]"
	_on_board.bbcode_text = b_template % _state.on_board
	_on_board.punch()

	var s_template = "[color=#63c74d]Safe: %s[/color]"
	_safe.bbcode_text = s_template % _state.safe
	_safe.punch()

	var d_template = "[color=#5a6988]Died: %s[/color]"
	_died.bbcode_text = d_template % _state.died
	_died.punch()
