extends MarginContainer


var _state = preload("res://src/GameState.tres")


func _ready():
	_state.connect("player_death", self, "_show")
	_state.connect("player_respawn", self, "_hide")


func _show():
	visible = true

func _hide():
	visible = false
