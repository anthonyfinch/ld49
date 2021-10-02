extends Label


var _state = preload("res://src/GameState.tres")


func _process(_delta):


	var mins = round(_state.time / 60.0)
	var secs = round(fmod(_state.time, 60.0))

	var template = "Time Remaining: %s:%s"
	text = template % [mins, secs]
