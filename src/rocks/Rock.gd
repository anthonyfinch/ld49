extends RigidBody


func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	print(body)
	if body.get_parent().has_method("rock_damage"):
		body.get_parent().rock_damage()

