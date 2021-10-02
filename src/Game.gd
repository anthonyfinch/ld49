extends Control



var _state = preload("res://src/GameState.tres")

func _ready():
	_state.time = _state.time_limit


func _process(delta):
	if _state.time <= 0:
		_state.emit_signal("time_up")
		_state.time = 0.0
	else:
		_state.time -= delta
