extends Control


var _screens = {}
var _events = preload("res://src/screens/Events.tres")


func _ready():
	for screen in get_children():
		_screens[screen.name] = screen

	_events.connect("goto_screen", self, "_goto_screen")
	_events.connect("quit", self, "_quit")


func _goto_screen(screen):
	var new_screen
	var others = []
	for screen_name in _screens:
		if screen_name == screen:
			new_screen = _screens[screen_name]
			# _screens[screen_name].visible = true
		else:
			others.push_back(_screens[screen_name])
			# _screens[screen_name].visible = false

	assert(new_screen)

	new_screen.visible = true

	for screen in others:
		screen.visible = false

	if new_screen.has_method("enter"):
		new_screen.enter()


func _quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
