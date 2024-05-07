extends PhantomCamera3D

@export var mouse_sensitivity: float = 0.5
@onready var pcam: PhantomCamera3D = $PhantomCamera3D

var min_yaw: float = -89.9
var max_yaw: float = 50
var min_pitch: float = 0
var max_pitch: float = 360

func _ready():
	print(pcam)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var pcam_rotation_degrees: Vector3

		pcam_rotation_degrees = self.get_third_person_rotation_degrees()
		pcam_rotation_degrees.x -= event.relative.y * mouse_sensitivity
		pcam_rotation_degrees.x = clampf(pcam_rotation_degrees.x, min_yaw, max_yaw)
		pcam_rotation_degrees.y -= event.relative.x * mouse_sensitivity
		pcam_rotation_degrees.y = wrapf(pcam_rotation_degrees.y, min_pitch, max_pitch)
		self.set_third_person_rotation_degrees(pcam_rotation_degrees)
