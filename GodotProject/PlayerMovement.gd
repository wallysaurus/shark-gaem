extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_central_force(Input.get_action_strength("ui_up") * Vector3.FORWARD * 12000.0 * delta)
