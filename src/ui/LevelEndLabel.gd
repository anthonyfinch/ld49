extends Label


var _state = preload("res://src/GameState.tres")


func _ready():
	_state.connect("time_up", self, "_update_label")


func _update_label():
	var safe = _state.safe
	var unsafe = _state.on_board + _state.died
	if _state.people:
		unsafe += _state.people.get_children().size()
	var total = unsafe + safe
	text = "Time's up! You rescued: %s out of %s people." % [safe, total]
