extends RigidBody3D
class_name Enemy


const SPEED = 5.0


func _physics_process(delta: float) -> void:
	global_position.z += (delta * SPEED)

func kill() -> void:
	queue_free()


func _on_body_entered(body):
	if body is Friendly:
		body.queue_free()
		queue_free()
