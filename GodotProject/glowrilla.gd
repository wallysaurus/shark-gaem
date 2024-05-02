extends Node3D
@onready var monkey : RigidBody3D = $"."
@onready var moved : int = 0
@onready var distance: int = 100
@onready var setting: int = 0
	
func switch():
	monkey.rotate_y(deg_to_rad(180.0))
	
func moveLeft(time):
	monkey.move_and_collide(Vector3.FORWARD * 6 * time)
	moved -= 1

func moveRight(time):
	monkey.move_and_collide(Vector3.BACK * 6 * time)
	moved += 1
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	"physics_material_override"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moved == 0:
		switch()
		setting = 0
	if moved == distance:
		switch()
		setting = 1
	if setting == 0:
		moveRight(delta)
	elif setting == 1:
		moveLeft(delta)
	
		
