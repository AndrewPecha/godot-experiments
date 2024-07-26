extends MeshInstance3D

@export var projectile: PackedScene

const RAY_LENGTH = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		# modified from https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
		var space_state = get_world_3d().direct_space_state
		var cam = get_node("../Camera3D")
		var mousepos = get_viewport().get_mouse_position()

		var origin = cam.project_ray_origin(mousepos)
		var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true

		var result = space_state.intersect_ray(query)
		if result == {}:
			return
		print("target: " + str(result.position))
		print("position: " + str(position))
		shoot_at(result.position)
		
func shoot_at(target: Vector3) -> void:
	var shot_vector = Vector3(target.x, position.y, target.z) - position

	var projectile_instance: PlaceholderProjectile = projectile.instantiate()
	projectile_instance.global_position = global_position
	projectile_instance.set_destination_cubic(target, 20, 20, 3)
	get_tree().root.get_node("World").add_child(projectile_instance)
	
	var projectile_instance_2: PlaceholderProjectile = projectile.instantiate()
	projectile_instance_2.global_position = global_position
	projectile_instance_2.set_destination_cubic(target, -20, -20, 3)
	get_tree().root.get_node("World").add_child(projectile_instance_2)
