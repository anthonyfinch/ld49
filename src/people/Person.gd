extends RigidBody


signal person_collected(person)
signal fell_in_sea(person)


onready var _detector = $PlayerDetector
onready var _ray = $Ray

var _in_sea = false


func _ready():
	_detector.connect("body_entered", self, "_on_player_entered")
	connect("tree_exited", self, "_on_remove")


func _on_player_entered(_player):
	queue_free()


func _on_remove():
	emit_signal("person_collected", self)


func _physics_process(delta):
	var in_sea = _ray.is_colliding()
	if not _in_sea and in_sea:
		emit_signal("fell_in_sea")

	_in_sea = in_sea


func in_peril():
	return _in_sea
