extends Spatial


onready var body = $Body
onready var mesh = $Mesh
onready var ray = $Mesh/RayCast

var acceleration = 50
var steering = 21.0
var turn_speed = 5
var turn_stop_limit = 0.75

var speed_input = 0
var rotate_input = 0


func _ready():
	ray.add_exception(body)


func _physics_process(_delta):
	mesh.transform.origin = body.transform.origin
	body.add_central_force(-mesh.global_transform.basis.z * speed_input)


func _process(delta):
	if not ray.is_colliding():
		return

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