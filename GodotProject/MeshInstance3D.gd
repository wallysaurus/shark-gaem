@tool
extends MeshInstance3D

@export var width: int = 100:
	set(new_width):
		width = new_width
		update_terrain()
@export var depth: int = 100:
	set(new_depth):
		depth = new_depth
		update_terrain()
@export var cell_size: float = 1.0:
	set(new_cell_size):
		cell_size = new_cell_size
		update_terrain()
@onready var noise = FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_noise()
	update_terrain()

func setup_noise():
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.fractal_octaves = 4
	noise.frequency = 0.02
	noise.domain_warp_amplitude = 5.0

func update_terrain():
	if self.mesh == null:
		self.mesh = ArrayMesh.new()
		
		
		
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	for i in range(width):
		for j in range(depth):
			var x = i * cell_size
			var z = j * cell_size
			var y = noise.get_noise_3d(x, 0, z) * 4
			var vertex = Vector3(x, y, z)
			st.add_vertex(vertex)
	
	for i in range(width - 1):
		for j in range(width - 1):
			var a = i * depth + j
			var b = (i + 1) * depth + j
			var c = (i + 1) * depth + (j + 1)
			var d = i * depth + (j + 1)
		
			st.add_index(a)
			st.add_index(b)
			st.add_index(d)
			st.add_index(b)
			st.add_index(c)
			st.add_index(d)
	
	st.generate_normals()
	var generated_mesh = st.commit()
	self.mesh = generated_mesh
	$CollisionShape3D.shape = generated_mesh.create_trimesh_shape()
