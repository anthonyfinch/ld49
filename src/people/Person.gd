extends RigidBody


signal person_collected(person)


onready var detector = $PlayerDetector


func _ready():
	detector.connect("body_entered", self, "_on_player_entered")


func _on_player_entered(_player):
	emit_signal("person_collected", self)
	queue_free()
