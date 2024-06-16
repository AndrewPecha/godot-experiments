extends CharacterBody3D
class_name Friendly


const SPEED = 5.0


func _physics_process(delta: float) -> void:
	global_position.z += -(delta * SPEED)

func kill() -> void:
	queue_free()
