extends Spatial


onready var detector = $Area

var _state = preload("res://src/GameState.tres")

func _ready():
	detector.connect("body_entered", self, "_on_player_entered")


func _on_player_entered(_player):
	_state.drop_off()
