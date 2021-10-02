extends Spatial


export (float) var start_timeout = 10.0
export (float) var end_timeout = 4.0

var _timeout = 0.0
var _tween
var _timer
var _state = preload("res://src/GameState.tres")


func _ready():
	_tween = Tween.new()
	add_child(_tween)
	_tween.interpolate_property(self, "_timeout", start_timeout, end_timeout, _state.time_limit, Tween.EASE_LINEAR, Tween.EASE_IN)

	 
