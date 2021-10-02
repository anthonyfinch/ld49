extends Button


var _state = preload("res://src/GameState.tres")


func _ready():
	connect("pressed", self, "_on_press")


func _on_press():
	get_tree().reload_current_scene()
