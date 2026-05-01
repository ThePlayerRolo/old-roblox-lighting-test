@tool
extends Node3D

@onready var sky_mesh = preload("res://External/SimpleSkybox/skybox.obj")

@export var TextureFront:Texture = null

@export var TextureBack:Texture = null

@export var TextureBottom:Texture = null

@export var TextureUp:Texture = null

@export var TextureLeft:Texture = null

@export var TextureRight:Texture = null

func create_mat(texture:Texture, isTop:bool = false, isBottom:bool = false):
	var m:StandardMaterial3D = StandardMaterial3D.new()
	m.flags_unshaded = true
	var imageRotate:Image = texture.get_image()
	if isTop:
		imageRotate.rotate_90(CLOCKWISE)
	elif isBottom:
		imageRotate.rotate_180()
		imageRotate.rotate_90(CLOCKWISE)
	# imageRotate.rotate_90(CLOCKWISE)
	var textureRotate:Texture = ImageTexture.create_from_image(imageRotate)
	m.albedo_texture = textureRotate
	return m

func _ready():
	var i_mesh = MeshInstance3D.new()
	i_mesh.name = "SkyMeshInstance"
	i_mesh.mesh = sky_mesh
	add_child(i_mesh)
	i_mesh.set_surface_override_material(0, create_mat(TextureBottom, false, true))
	i_mesh.set_surface_override_material(1, create_mat(TextureUp, true))
	i_mesh.set_surface_override_material(2, create_mat(TextureFront))
	i_mesh.set_surface_override_material(3, create_mat(TextureLeft))
	i_mesh.set_surface_override_material(4, create_mat(TextureBack))
	i_mesh.set_surface_override_material(5, create_mat(TextureRight))
	
