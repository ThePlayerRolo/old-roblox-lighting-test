extends Node3D


@export var meshType : Part_Enums.MESH_TYPE = Part_Enums.MESH_TYPE.MESH_SPECIAL
@onready var material: StandardMaterial3D = preload("res://Resources/Shader/OldRobloxTexture.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh = MeshInstance3D.new()
	var surfaceData:Part_SurfaceData = CreateSpecialMesh.createSurfaceData("res://Models//MeshType//Chessboard.mesh")
	mesh.mesh = surfaceData.createArrayMesh()
	add_child(mesh)
	mesh.set_surface_override_material(0, material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
