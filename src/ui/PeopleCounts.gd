extends VBoxContainer

onready var _stranded = $Stranded
onready var _in_peril = $InPeril
onready var _on_board = $OnBoard
onready var _safe = $Safe


var _stranded_count = 0
var _peril_count = 0

var _state = preload("res://src/GameState.tres")


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

				
		if stranded != _stranded_count:
			var p_template = "[color=yellow]Stranded: %s[/color]\n"
			_stranded.bbcode_text = p_template % stranded
			_stranded_count = stranded

		if in_peril != _peril_count:
			var i_template = "[color=red]In Peril!: %s[/color]\n"
			_in_peril.bbcode_text = i_template % in_peril
			_peril_count = in_peril


func _update_counts():
	var b_template = "[color=blue]On Board: %s[/color]\n"
	_on_board.bbcode_text = b_template % _state.on_board

	var s_template = "[color=green]Safe: %s[/color]\n"
	_safe.bbcode_text = s_template % _state.safe
