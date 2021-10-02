extends Spatial

var _state = preload("res://src/GameState.tres")


func _ready():
	_state.people = self
