extends KinematicBody

var vel = Vector3()
const MAX_SPEED = 20
const JUMP_SPEED = 18
const ACCEL= 4.5

const MAX_SPRINT_SPEED = 30
const SPRINT_ACCEL = 18
var is_sprinting = false
var dir = Vector3()
const DEACCEL= 16




onready var camera = $Camera



func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	




func _input(event):
	
	
	if event is InputEventMouseMotion:
		rotate_camera(event.relative)
	
	update_movement_direction()


func _physics_process(delta):
	process_movement(delta)


func update_movement_direction():
	
	

	# ----------------------------------
	# Walking
	dir = Vector3()
	

	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("move_player_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_player_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("move_player_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_player_right"):
		input_movement_vector.x = 1
	
	input_movement_vector = input_movement_vector.normalized()
	
	var camera_basis = camera.get_global_transform().basis
	dir += -camera_basis.z.normalized() * input_movement_vector.y
	dir += camera_basis.x.normalized() * input_movement_vector.x
	dir.y = 0
	dir = dir.normalized()
	
	
	# ----------------------------------

	
	
	


func rotate_camera(relative_movement):
	
	# Rotate horizontally
	camera.rotate_y(deg2rad(relative_movement.x *0.1 * -1))
	# Rotate vertically
	var angle = -relative_movement.y * 0.1
	var camera_rot = camera.rotation_degrees
	camera_rot.x += angle
	camera_rot.x = clamp(camera_rot.x, -80, 80)
	camera.rotation_degrees = camera_rot



func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	var hvel = vel
	hvel.y = 0

	var target = dir
	if is_sprinting:
		target *= MAX_SPRINT_SPEED
	else:
		target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		if is_sprinting:
			accel = SPRINT_ACCEL
		else:
			accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel*delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel-get_floor_normal()*4.0,Vector3(0,1,0))
	if(!is_on_floor()):
		vel.y -= 9.81 *4* delta
	
