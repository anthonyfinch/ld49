extends Control


export (float) var time_limit = 60.0 * 3.0

var _state = preload("res://src/GameState.tres")

func _ready():
	_state.time = time_limit


func _process(delta):
	if _state.time <= 0:
		_state.emit_signal("time_up")
		_state.time = 0.0
	else:
		_state.time -= delta
