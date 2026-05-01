class_name Part_SurfaceData
extends Node

var vertices : PackedVector3Array;
var indices : PackedInt32Array;
var normals : PackedVector3Array;
var texCoords : PackedVector2Array;
var usesIndices : bool;

func _init(useIndices:bool = false):
	print("Creating Part Surface Data....")
	vertices = PackedVector3Array()
	indices = PackedInt32Array();
	normals = PackedVector3Array();
	texCoords = PackedVector2Array();
	usesIndices = useIndices

func appendVertexData(vertexPos:Vector3, vertexNormal:Vector3, vertexTexCoord:Vector2):
	vertices.append(vertexPos)
	normals.append(vertexNormal)
	texCoords.append(vertexTexCoord)

func createArrayMesh() -> ArrayMesh:
	var surface_array = []
	var array_mesh : ArrayMesh = ArrayMesh.new()
	
	surface_array.resize(Mesh.ARRAY_MAX)
	surface_array[Mesh.ARRAY_VERTEX] = vertices
	surface_array[Mesh.ARRAY_NORMAL] = normals
	surface_array[Mesh.ARRAY_TEX_UV] = texCoords
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	return array_mesh
	#surface_array[Mesh.ARRAY_INDEX] = indices
	
