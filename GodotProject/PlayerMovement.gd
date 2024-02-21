extends RigidBody3D
@onready var Player : RigidBody3D = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Player.apply_central_impulse(Input.get_action_strength("forward") * Vector3.FORWARD * 25.0 * delta)
	Player.apply_central_impulse(Input.get_action_strength("left") * Vector3.LEFT * 25.0 * delta)
	Player.apply_central_impulse(Input.get_action_strength("right") * Vector3.RIGHT * 25.0 * delta)
	Player.apply_central_impulse(Input.get_action_strength("backward") * -Vector3.FORWARD * 25.0 * delta)
	print(Player.global_position)
