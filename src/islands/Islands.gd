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
	_tween.interpolate_property(self, "_timeout", start_timeout, end_timeout, _state.time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_tween.start()

	_timer = Timer.new()
	_timer.wait_time = start_timeout
	_timer.one_shot = true
	_timer.connect("timeout", self, "_trigger_sinking")
	add_child(_timer)
	_timer.start()


func _trigger_sinking():
	_timer.wait_time = _timeout
	_timer.start()
	for island in get_children():
		if island.has_method("sink"):
			if not island.sinking and not island.safe:
				island.sink()
				break
