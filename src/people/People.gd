extends Spatial

var _state = preload("res://src/GameState.tres")


func _ready():
	_state.people = self
	for person in get_children():
		person.connect("person_collected", self, "_on_person_collected")
		person.connect("fell_in_sea", self, "_on_person_in_sea")
		person.connect("died", self, "_on_person_died")


func _on_person_collected(person):
	_state.collect_person()


func _on_person_in_sea(person):
	_state.emit_signal("counts_updated")


func _on_person_died(person):
	_state.person_died()
