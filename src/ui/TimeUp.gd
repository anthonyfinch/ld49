extends MarginContainer


var _state = preload("res://src/GameState.tres")


func _ready():
	_state.connect("time_up", self, "_show")


func _show():
	visible = true
