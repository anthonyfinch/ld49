extends ProgressBar


var _state = preload("res://src/GameState.tres")


func _ready():
	_state.connect("health_updated", self, "_update_health")
	_update_health()

func _update_health():
	value = _state.health
