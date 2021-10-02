extends RigidBody


signal person_collected(person)


onready var detector = $PlayerDetector


func _ready():
	detector.connect("body_entered", self, "_on_player_entered")
	connect("tree_exited", self, "_on_remove")


func _on_player_entered(_player):
	queue_free()


func _on_remove():
	emit_signal("person_collected", self)
