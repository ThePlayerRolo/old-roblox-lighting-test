class_name CreateSpecialMesh
extends Node

enum SPECIAL_MESH_VERSIONS {
	VERSION_1,
	VERSION_1_01
}

# Local function for formatting assert
static func formatAssert(function:String, error:String, params:Dictionary) -> String:
	return "CreateSpecialMesh::" + function + "() " + error.format(params)
	

static func flipNormals(ogNormals : Vector3) -> Vector3:
	return Vector3(ogNormals.x, ogNormals.y, ogNormals.z)

static func createSurfaceData(fileName: String) -> Part_SurfaceData:
	var funcName = "createSurfaceData"
	
	var surfaceData = Part_SurfaceData.new();
	var meshFile = FileAccess.open(fileName, FileAccess.READ)
	assert(meshFile != null, formatAssert(funcName, "Mesh file {fileName} not found!", {"fileName" : fileName}))
	
	var meshData := meshFile.get_as_text()
	meshData = meshData.replace("\n", "")
	meshData = meshData.replace("\r", "")
	meshData = meshData.replace("\t", "")
	
	assert(meshData.begins_with("version 1.00") or meshData.begins_with("version 1.01"), 
	formatAssert(funcName, "{fileName} is not a valid 1.0 mesh file!", {"fileName" : fileName}))
	
	var version:SPECIAL_MESH_VERSIONS = SPECIAL_MESH_VERSIONS.VERSION_1 
	if meshData.substr(0, 12).contains("1.01"): 
		version = SPECIAL_MESH_VERSIONS.VERSION_1_01  
	
	meshData = meshData.erase(0, 12)
	
	var firstBracket:int = meshData.find("[")
	var faceCount:int = int(meshData.substr(0, firstBracket))
	assert(faceCount != null, formatAssert(funcName, "{fileName}'s face count is invalid!", {"fileName" : fileName}))
	
	meshData = meshData.erase(0, firstBracket)
	
	for i in faceCount:
		var vertsPositions:PackedVector3Array
		var vertsNormals:PackedVector3Array
		var vertsTexcoords:PackedVector2Array
		for j in 3:
			var pos:int = meshData.find("[")
			var vertPosition:Vector3;
			var vertNormals:Vector3;
			var vertTexCoords:Vector2;

			meshData = meshData.erase(0, pos+1)
			
			# X Position
			pos = meshData.find(",")
			vertPosition.x = float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			
			# Y Position
			pos = meshData.find(",")
			vertPosition.y = float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			
			# Z Position
			pos = meshData.find(",")
			vertPosition.z = float(meshData.substr(0, pos))
			
			pos = meshData.find("[")
			
			meshData = meshData.erase(0, pos+1)
			# X Normal
			pos = meshData.find(",")
			vertNormals.x = float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			
			# Y Normal
			pos = meshData.find(",")
			vertNormals.y = float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			
			# Z Normal
			pos = meshData.find(",")
			vertNormals.z = float(meshData.substr(0, pos))
			
			pos = meshData.find("[")
			meshData = meshData.erase(0, pos+1)
			
			# X Tex
			pos = meshData.find(",")
			vertTexCoords.x = float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			
			# Y Tex
			pos = meshData.find(",")
			
			vertTexCoords.y = 1 - float(meshData.substr(0, pos))
			meshData = meshData.erase(0, pos+1)
			pos = meshData.find("]")

			meshData = meshData.erase(0, pos+1)
			
			if version == SPECIAL_MESH_VERSIONS.VERSION_1:
				vertPosition *= 0.5
			vertsPositions.append(vertPosition)
			vertsNormals.append(vertNormals)
			vertsTexcoords.append(vertTexCoords)
		surfaceData.appendVertexData(vertsPositions[0], vertsNormals[0], vertsTexcoords[0])
		surfaceData.appendVertexData(vertsPositions[2], vertsNormals[2], vertsTexcoords[2])
		surfaceData.appendVertexData(vertsPositions[1], vertsNormals[1], vertsTexcoords[1])
		vertsPositions.clear()
		vertsNormals.clear()
		vertsTexcoords.clear()
	
	return surfaceData;
