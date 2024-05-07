@tool
extends StaticBody3D

@export var Generate = false:
	get:
		return Generate;
	set(_gen):
		Generate = _gen;
		generate_mesh();

func generate_mesh():
	print("Generating mesh..")
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(4,4)
	plane_mesh.subdivide_depth = 3
	plane_mesh.subdivide_width = 3
	
	$MeshInstance3D.mesh = plane_mesh
