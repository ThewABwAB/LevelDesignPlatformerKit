extends Node3D
var mesh : MeshInstance3D
##At less than this distance the object will become fully transparent
@export var min_distance_dither : float = 2
##At more than this distance the object will become fully opaque
@export var max_distance_dither : float = 5
var mesh_mat : Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var siblings = get_parent().get_children()
	for _child in siblings:
		if _child is MeshInstance3D:
			mesh = _child
	
	if mesh == null:
		printerr("DitherObstacle object must be placed as a sibling of a mesh! ", name)
	else:
		mesh_mat = mesh.get_active_material(0)
		var new_mat : Material = mesh_mat.duplicate()
		new_mat.distance_fade_mode = 2
		new_mat.distance_fade_min_distance = min_distance_dither
		new_mat.distance_fade_max_distance = max_distance_dither
		mesh.set_surface_override_material(0,new_mat)
