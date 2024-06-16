extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while is_colliding():
		var collision = get_collider()
		add_exception_rid(get_collider_rid())
		force_raycast_update()
		if(collision is Friendly):
			collision.kill()
