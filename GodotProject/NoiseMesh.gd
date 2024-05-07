extends MeshInstance3D

func _ready():
	var the_mesh = ArrayMesh.new()
	
	var noise = FastNoiseLite.new()  # Using FastNoiseLite
	noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)  # Set the noise type to Perlin
	noise.seed = randi()  # Random seed for variety
	noise.set_octave_count(4)  # More octaves for more detail
	noise.set_period(20.0)  # Period of the noise
	
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	var size = 10 # Define the grid size
	var spacing = 1.0 # Spacing between vertices

	# Generate vertices
	for i in range(size):
		for j in range(size):
			var x = i * spacing
			var z = j * spacing
			var y = noise.get_noise_2d(x, z) # Use noise for y value
			st.add_vertex(Vector3(x, y, z))

	# Generate faces
	for i in range(size - 1):
		for j in range(size - 1):
			var a = i * size + j
			var b = (i + 1) * size + j
			var c = (i + 1) * size + (j + 1)
			var d = i * size + (j + 1)
			# Two triangles per square
			st.add_index(a)
			st.add_index(b)
			st.add_index(c)
			st.add_index(a)
			st.add_index(c)
			st.add_index(d)

	# Commit the mesh and apply it to the MeshInstance3D
	st.commit(the_mesh)
	self.mesh = the_mesh

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
