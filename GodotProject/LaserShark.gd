extends CharacterBody3D

@export var speed := 7.0

var _velocity := Vector3.ZERO

@onready var _spring_arm: SpringArm3D = $SpringArm3D

func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.y = Input.get_action_strength("forward") - Input.get_action_strength("back")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	
func _process(_delta: float) -> void:
