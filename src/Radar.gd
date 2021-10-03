extends Control

export (Color) var bg_color
export (Color) var stranded_person_color
export (Color) var peril_person_color
export (Color) var zone_color
export (float) var scale = 1.0

onready var _ship_icon = $TextureRect

var _state = preload("res://src/GameState.tres")
var _people = []
var _center = Vector2.ZERO
var _radius = 0.0
var _person_radius = 0.0


func _ready():
	 rect_pivot_offset = rect_size / 2
	 _ship_icon.rect_pivot_offset = _ship_icon.rect_size / 2
	 _center = rect_size / 2
	 _radius = min(_center.x, _center.y)
	 _person_radius = _radius / 10


func _process(_delta):
	var people = _state.people
	var player = _state.player

	if player:
		rect_rotation = player.rotation_degrees.y + player.mesh.rotation_degrees.y
		_ship_icon.rect_rotation = -1 * (player.rotation_degrees.y + player.mesh.rotation_degrees.y)

	_people = []
	if people and player:
		for person in people.get_children():
			var diff3 = person.global_transform.origin - player.body.global_transform.origin
			var diff = (Vector2(diff3.x, diff3.z) * scale).clamped(_radius)
			var c = stranded_person_color
			if person.in_peril():
				c = peril_person_color
			_people.push_back({"diff": diff, "color": c})

	update()


func _draw():
	draw_circle(_center, _radius, bg_color)

	for person in _people:
		draw_circle(_center + person["diff"], _person_radius, person["color"])

	if _state.zone and _state.player:
		var diff3 = _state.zone.global_transform.origin - _state.player.body.global_transform.origin
		var diff = (Vector2(diff3.x, diff3.z) * scale).clamped(_radius)
		draw_circle(_center + diff, _person_radius, zone_color)
