extends RigidBody3D

@export var underwater_speed = 14
@export var fall_acceleration = 75
@export var mouse_sensitivity: float = 0.5

var min_yaw: float = -89.9
var max_yaw: float = 50
var min_pitch: float = 0
var max_pitch: float = 360
var target_velocity = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if (Input.is_key_pressed(KEY_D)):
		direction.x += 1
		
	if (Input.is_key_pressed(KEY_A)):
		direction.x -= 1
	if (Input.is_key_pressed(KEY_S)):
		direction.z += 1
	if (Input.is_key_pressed(KEY_W)):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		self.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * underwater_speed
	target_velocity.z = direction.z * underwater_speed
	
	#if not is_on_floor():
	#target_velocity.y = target_velocity.y + (fall_acceleration * delta)
	

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
