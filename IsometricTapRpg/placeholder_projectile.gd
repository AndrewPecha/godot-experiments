extends Node3D
class_name PlaceholderProjectile

var shot_direction: Vector3
const SPEED = 8

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += shot_direction * SPEED * delta
