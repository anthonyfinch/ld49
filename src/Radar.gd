extends Control

export (Color) var bg_color
export (Color) var person_color
export (float) var scale = 1.0

var _state = preload("res://src/GameState.tres")
var _people = []
var _center = Vector2.ZERO
var _radius = 0.0
var _person_radius = 0.0


func _ready():
	 rect_pivot_offset = rect_size / 2
	 _center = rect_size / 2
	 _radius = min(_center.x, _center.y)
	 _person_radius = _radius / 10


func _process(_delta):
	var people = _state.people
	var player = _state.player

	if player:
		rect_rotation = player.mesh.rotation_degrees.y

	_people = []
	if people and player:
		for person in people.get_children():
			var diff3 = person.global_transform.origin - player.body.global_transform.origin
			var diff = (Vector2(diff3.x, diff3.z) * scale).clamped(_radius)
			_people.push_back(diff)

	update()


func _draw():
	# background circle
	draw_circle(_center, _radius, bg_color)

	for person in _people:
		draw_circle(_center + person, _person_radius, person_color)
