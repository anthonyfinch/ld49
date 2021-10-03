extends Control


var _tween = null

func _ready():
	rect_pivot_offset = rect_size / 2
	_tween = Tween.new()
	add_child(_tween)


func punch():
	_tween.remove_all()
	_tween.interpolate_property(self, "rect_scale", Vector2(0.5, 0.5), Vector2(1.0, 1.0), 0.6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	_tween.start()


