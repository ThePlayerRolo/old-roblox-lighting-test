class_name ArrayMeshUtils_old
extends Object

enum MESH_SIDES {
	SIDE_FRONT,
	SIDE_BACK,
	SIDE_LEFT,
	SIDE_RIGHT,
	SIDE_UP,
	SIDE_DOWN,
}

static func initSurfaceArrayData() -> Array:
	var array = []
	array.resize(Mesh.ARRAY_MAX)
	return array

static func addSurfaceArrayData(array:Array, vertices:PackedVector3Array, indices:PackedInt32Array) -> void:
	array[Mesh.ARRAY_VERTEX] = vertices
	array[Mesh.ARRAY_INDEX] = indices

static func addSurfaceFromArray(mesh:ArrayMesh, surface_array:Array) -> void:
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)

static func simpleAddOneSurface(array_mesh:ArrayMesh, vertices:PackedVector3Array, indices:PackedInt32Array) -> void:
	var arrays = ArrayMeshUtils_old.initSurfaceArrayData()
	ArrayMeshUtils_old.addSurfaceArrayData(arrays, vertices, indices)
	ArrayMeshUtils_old.addSurfaceFromArray(array_mesh, arrays)
