extends PhantomCamera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		#set_third_person_rotation(Vector3((get_viewport().get_visible_rect().size / 2) - event.global_position.x, 0, 0))
