extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewportLength = get_viewport().size.x
	var mousePositionRelativeToCenterOfViewport = get_viewport().get_mouse_position().x - (viewportLength / 2)
	var mouse_position_x = clampf(mousePositionRelativeToCenterOfViewport / 100, -1.8, 1.8)
	global_position.x = mouse_position_x

# use this if we wanna use a dedicated mouse position detection object
func _detect_mouse_position() -> Dictionary:
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var camera: Camera3D = get_node("../Camera3D")
	var from = (camera as Camera3D).project_ray_origin(mouse_pos)
	var to = from + ((camera as Camera3D).project_ray_normal(mouse_pos) * ray_length)
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var space = get_world_3d().direct_space_state
	var raycast_result = space.intersect_ray(ray_query)
	print(raycast_result["collider"])
	return raycast_result
