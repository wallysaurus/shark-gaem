extends PhantomCamera3D

var mouse_sensitivity: float = 0.05

var min_yaw: float = 0
var max_yaw: float = 360
var min_pitch: float = -89.9
var max_pitch: float = 50

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		var pcam_rotation_degrees: Vector3
		
		pcam_rotation_degrees = pcam.get_third_person_rotation_degrees()
		pcam_rotation_degrees.x -= event.relative.y * mouse_sensitivity
		pcam_rotation_degrees.x = clampf(pcam_rotation_degrees.x, min_pitch, max_pitch)
		
