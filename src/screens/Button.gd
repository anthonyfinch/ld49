extends Button
class_name ScreenButton


enum ScreenButtonType {
	GotoScreen
	Quit
}

export (ScreenButtonType) var action_type = ScreenButtonType.Quit
export (String) var goto_screen = ""


var _events = preload("res://src/screens/Events.tres")


func _ready():
	connect("pressed", self, "_on_press")


func _on_press():
	match action_type:
		ScreenButtonType.GotoScreen:
			_events.emit_signal("goto_screen", goto_screen)
		ScreenButtonType.Quit:
			_events.emit_signal("quit")
