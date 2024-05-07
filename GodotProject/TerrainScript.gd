@tool
extends StaticBody3D

@export var boobs: bool = false:
	get:
		return boobs
	set(new_boobs):
		boobs = new_boobs
		generate_mesh()
@export var size = 64
@export var subdivide = 63
@export var amplitude = 16
@export var noise = FastNoiseLite.new()
@export var adjustment: float = 0.1
@export var interpolation_speed = 0.05

var current_vertices = []
var target_vertices = []
var mesh_initialized = false

func generate_mesh():
	print('actually generating')
	
	# Create our base plane mesh.
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size, size)
	plane_mesh.subdivide_depth = subdivide
	plane_mesh.subdivide_width = subdivide
	
	# Surface tool allows us to findiddle with the mesh vertices
	# Data is a matrix of our vertices.
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var data = surface_tool.commit_to_arrays()
	target_vertices = data[ArrayMesh.ARRAY_VERTEX]
	
	# Loop through all the vertices and adjust their y value based on noisemap.
	for i in target_vertices.size():
		var vertex = target_vertices[i]
		target_vertices[i].y = noise.get_noise_2d(vertex.x, vertex.z) * amplitude
	if not mesh_initialized:
		current_vertices = target_vertices.duplicate()
		mesh_initialized = true
	
	update_mesh(data)

func update_mesh(data):
	data[ArrayMesh.ARRAY_VERTEX] = current_vertices
	
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, data)
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()
	
	$Terrain.mesh = surface_tool.commit()
	$CollisionShape3D.shape = array_mesh.create_trimesh_shape()
	
func _ready():
	generate_mesh()
	current_vertices = target_vertices.duplicate()
	# for some reason lerping needs this i dunno
	set_process(true)

func _process(delta):
	var change = false
	for i in range(current_vertices.size()):
		var current_y = current_vertices[i].y
		var target_y = target_vertices[i].y
		if current_y != target_y:
			current_vertices[i].y = lerp(current_y, target_y, interpolation_speed * delta)
			change = true
	if change:
		var data = $Terrain.mesh.surface_get_arrays(0)[Mesh.ARRAY_VERTEX]
		update_mesh(data)

func _on_timer_timeout():
	adjustment += 1
	generate_mesh()
