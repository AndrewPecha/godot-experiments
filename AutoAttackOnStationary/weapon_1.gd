extends Sprite2D

@export var projectile: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fire(target_direction: Vector2):
	var projectile_instance = projectile.instantiate()
	projectile_instance.direction = target_direction
	projectile_instance.global_position = $ProjectileSpawn.global_position
	get_tree().root.get_node("World").add_child(projectile_instance)
