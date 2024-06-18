extends RigidBody3D
class_name Friendly

var gateways_used: Array[int] = []

const SPEED = 5.0


func _physics_process(delta: float) -> void:
	global_position.z += -(delta * SPEED)

func kill() -> void:
	queue_free()
