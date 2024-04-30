extends Node3D
@onready var Glowrilla : RigidBody3D = $"."
@onready var moved : int = 0

func switch():
	Glowrilla.transform.rotated 
	moved = 0
	print("switched")
	
func move(time):
	Glowrilla.move_and_collide(Vector3.FORWARD * 6 * time)
	moved += 1
	print("moved")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	"physics_material_override"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (moved < 50):
		move(delta)
	else: 
		switch()
