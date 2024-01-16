extends CharacterBody3D

@export var speed := 0.5

var _velocity := Vector3.ZERO

@onready var _spring_arm: SpringArm3D = $SpringArm3D
@onready var _model: Node3D = $Shark

func _physics_process(delta: float) -> void:
	if (Input.is_key_pressed(KEY_W)):
		_model.global_position += Vector3.FORWARD * speed
		print(_model.global_position)
	if (Input.is_key_pressed(KEY_S)):
		_model.global_position += Vector3.BACK * speed
		print(_model.global_position)
	if (Input.is_key_pressed(KEY_A)):
		_model.global_position += Vector3.LEFT * speed
		print(_model.global_position)
	if (Input.is_key_pressed(KEY_D)):
		_model.global_position += Vector3.RIGHT * speed
		print(_model.global_position)
	
	#var move_direction := Vector3.ZERO
	#move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#move_direction.y = Input.get_action_strength("forward") - Input.get_action_strength("back")
	#move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	#
	#_velocity.x = move_direction.x * speed
	#_velocity.z = move_direction.z * speed
	#
	#if _velocity.length() > 0.2:
		#var look_direction = Vector2(_velocity.z, _velocity.x)
		#_model.rotation.y = look_direction.angle()
	#
#func _process(_delta: float) -> void:
	#_spring_arm.translation = Translation
