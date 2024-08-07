extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var angle_deviance: float = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	handle_movement()
	
	var camera_rotation = Input.get_axis("q", "e")
	if camera_rotation < 0:
		rotate_y(PI * delta)
		angle_deviance += PI * delta
		
	elif camera_rotation > 0:
		rotate_y(-PI * delta)
		angle_deviance += -PI * delta
	
func handle_movement() -> void:
	var direction_x: float = Input.get_axis("left", "right")
	var direction_z: float = Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_z:
		velocity.z = direction_z
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED)

	velocity = velocity.normalized().rotated(Vector3.UP, angle_deviance) * SPEED

	move_and_slide()
