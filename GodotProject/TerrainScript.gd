@tool
extends StaticBody3D

@export var size = 64
@export var subdivide = 63
@export var amplitude = 16
@export var noise = FastNoiseLite.new()
@export var adjustment: float = 0.1

func generate_mesh():
	print('actually generating')
	
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(size, size)
	plane_mesh.subdivide_depth = subdivide
	plane_mesh.subdivide_width = subdivide
	
	var surface_tool = SurfaceTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var data = surface_tool.commit_to_arrays()
	var vertices = data[ArrayMesh.ARRAY_VERTEX]
	
	for i in vertices.size():
		var vertex = vertices[i]
		vertices[i].y = noise.get_noise_2d(vertex.x + adjustment, vertex.z) * amplitude
	data[ArrayMesh.ARRAY_VERTEX] = vertices
	
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, data)
	
	surface_tool.create_from(array_mesh, 0)
	surface_tool.generate_normals()

	$Terrain.mesh = surface_tool.commit()
	$CollisionShape3D.shape = array_mesh.create_trimesh_shape()
	
func _ready():
	if not Engine.is_editor_hint():
		generate_mesh()

func _on_timer_timeout():
	adjustment += 1
	generate_mesh()
