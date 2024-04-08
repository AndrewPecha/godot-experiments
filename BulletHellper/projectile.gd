extends Area2D

const SPEED = 300.0
var direction: Vector2 = Vector2(0, 0)

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	body.damage_player(1)
	queue_free()
