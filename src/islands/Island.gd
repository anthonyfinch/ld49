extends Spatial

export (float) var shake = 1.0
export (bool) var safe = false

onready var _mesh = $Spatial/Mesh

var _tween
var sinking = false


func _ready():
	_tween = Tween.new()
	_tween.playback_process_mode = Tween.TWEEN_PROCESS_PHYSICS
	add_child(_tween)


func sink():
	var start = translation.y
	_tween.interpolate_property(self, "translation:y", start, start - 10, 6.0, Tween.TRANS_LINEAR, Tween.EASE_IN, 2.0)
	sinking = true
	_tween.start()


func _process(delta):
	if sinking:
		var x_off = randf() * shake
		var y_off = randf() * shake
		_mesh.translation.x = x_off
		_mesh.translation.y = y_off
	if translation.y <= -2.5:
		queue_free()
