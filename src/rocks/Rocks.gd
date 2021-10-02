extends Spatial


export (bool) var active = true
export (float) var start_timeout = 5.0
export (float) var end_timeout = 1.0

var _timeout = 0.0
var _tween
var _timer
var _state = preload("res://src/GameState.tres")
var _rock_storm = preload("res://src/rocks/RockStorm1.tscn")


func _ready():
	_tween = Tween.new()
	add_child(_tween)
	_tween.interpolate_property(self, "_timeout", start_timeout, end_timeout, _state.time_limit, Tween.TRANS_LINEAR, Tween.EASE_IN)
	_tween.start()

	_timer = Timer.new()
	_timer.wait_time = start_timeout
	_timer.one_shot = true
	_timer.connect("timeout", self, "_trigger_rockstorm")
	add_child(_timer)
	_timer.start()
	_trigger_rockstorm()


func _trigger_rockstorm():
	_timer.wait_time = _timeout
	_timer.start()
	if active:
		var storm = _rock_storm.instance()
		add_child(storm)
		storm.transform.origin.y = transform.origin.y
		storm.transform.origin.x = _state.player.body.transform.origin.x
		storm.transform.origin.z = _state.player.body.transform.origin.z
