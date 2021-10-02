extends VBoxContainer

onready var _stranded = $Stranded
onready var _in_peril = $InPeril
onready var _on_board = $OnBoard
onready var _safe = $Safe

var _state = preload("res://src/GameState.tres")


func _ready():
	_state.connect("counts_updated", self, "_update_counts")
	_update_counts()


func _update_counts():
	if _state.people:
		var p_template = "[color=yellow]Stranded: %s[/color]\n"
		_stranded.bbcode_text = p_template % _state.people.get_children().size()

	var b_template = "[color=blue]On Board: %s[/color]\n"
	_on_board.bbcode_text = b_template % _state.on_board

	var s_template = "[color=green]Safe: %s[/color]\n"
	_safe.bbcode_text = s_template % _state.safe
