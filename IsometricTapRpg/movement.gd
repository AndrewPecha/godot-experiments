extends Node3D

var velocity: Vector3
const SPEED: float = 5
var parent: Node3D

func _ready() -> void:
	parent = get_parent()

func _physics_process(delta):
	var direction_x = Input.get_axis("left", "right")
	var direction_z = Input.get_axis("up", "down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_z:
		velocity.z = direction_z * SPEED
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	parent.position = parent.position + (velocity * delta)
