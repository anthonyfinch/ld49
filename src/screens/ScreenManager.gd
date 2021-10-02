extends Node2D


var _screens = {}
var _events = preload("res://src/screens/Events.tres")


func _ready():
	for screen in get_children():
		_screens[screen.name] = screen

	_events.connect("goto_screen", self, "_goto_screen")
	_events.connect("quit", self, "_quit")


func _goto_screen(screen):
	for screen_name in _screens:
		if screen_name == screen:
			_screens[screen_name].visible = true
		else:
			_screens[screen_name].visible = false


func _quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
