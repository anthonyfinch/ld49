extends Spatial


onready var body = $Body
onready var mesh = $Mesh
onready var ray = $Mesh/RayCast

var jump_force = 15
var acceleration = 50
var steering = 21.0
var turn_speed = 5
var turn_stop_limit = 0.75

var speed_input = 0
var rotate_input = 0

var _state = preload("res://src/GameState.tres")
var _paused = false
var _death_timer
var _original_pos
var _should_jump = false
var _jumped = false


func _ready():
	_original_pos = body.transform.origin
	_state.player = self
	ray.add_exception(body)
	_state.connect("time_up", self, "_pause")

	_death_timer = Timer.new()
	_death_timer.wait_time = 3.0
	_death_timer.one_shot = true
	add_child(_death_timer)
	_death_timer.connect("timeout", self, "_respawn")


func _pause():
	_paused = true


func _unpause():
	_paused = false


func rock_damage():
	if not _paused:
		_state.health -= 40
		if _state.health <= 0:
			_death()


func _death():
	_pause()
	_death_timer.start()
	_state.emit_signal("player_death")


func _respawn():
	_state.health = 100
	body.transform.origin = _original_pos
	_unpause()
	_state.emit_signal("player_respawn")



func _physics_process(_delta):
	if not _paused:
		mesh.transform.origin = body.transform.origin
		body.add_central_force(-mesh.global_transform.basis.z * speed_input)

		if _should_jump and not _jumped:
			_jumped = true
			_should_jump = false
			body.apply_central_impulse(mesh.global_transform.basis.y * jump_force)


func _process(delta):
	if not ray.is_colliding() or _paused:
		return

	if not _jumped and Input.is_action_pressed("jump"):
		_should_jump = true
	elif _jumped:
		_jumped = false

	speed_input = 0
	speed_input += Input.get_action_strength("accelerate")
	speed_input -= Input.get_action_strength("brake")
	speed_input *= acceleration
	rotate_input = 0
	rotate_input += Input.get_action_strength("steer_left")
	rotate_input -= Input.get_action_strength("steer_right")
	rotate_input *= deg2rad(steering)

	if body.linear_velocity.length() > turn_stop_limit:
		var new_basis = mesh.global_transform.basis.rotated(mesh.global_transform.basis.y, rotate_input)
		mesh.global_transform.basis = mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		mesh.global_transform = mesh.global_transform.orthonormalized()
