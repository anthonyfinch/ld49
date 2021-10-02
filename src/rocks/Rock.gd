extends RigidBody

var _hit = false
var _hit_player = false
var _tween


func _ready():
	connect("body_entered", self, "_on_body_entered")
	_tween = Tween.new()
	_tween.playback_process_mode = Tween.TWEEN_PROCESS_PHYSICS
	add_child(_tween)


func _on_body_entered(body):
	var mat = $MeshInstance["material/0"]
	if not _hit:
		_tween.interpolate_property(mat, "albedo_color:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		_tween.start()
		_tween.connect("tween_all_completed", self, "_on_fade_out")
		_hit = true

	if not _hit_player and body.get_parent().has_method("rock_damage"):
		if mat.albedo_color.a > 0.5:
			body.get_parent().rock_damage()
			_hit_player = true


func _on_fade_out():
	queue_free()
