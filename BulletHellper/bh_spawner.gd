extends Node2D

@export var projectile: PackedScene

@export var rotate_self: bool = true
@export var shoot_cooldown_timeout: float = 1.0
var shoot_cooldown_counter: float = 0

@export var full_rotation_time: float = 5.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_rotation(delta)
	handle_shooting(delta)
	
func handle_rotation(delta: float):
	if rotate_self:
		rotate(2 * PI * (delta / full_rotation_time))

func handle_shooting(delta: float) -> void:
	shoot_cooldown_counter += delta
	if shoot_cooldown_counter >= shoot_cooldown_timeout:
		shoot()
		shoot_cooldown_counter = 0
		
func shoot() -> void:
	var shot_direction: Vector2
	
	if rotate_self:
		shot_direction = Vector2.RIGHT.rotated(rotation)
	else:
		shot_direction = Vector2.RIGHT
	
	var projectile_instance = projectile.instantiate()
	projectile_instance.direction = shot_direction
	var world = get_tree().root.get_node("World")
	world.add_child(projectile_instance)
	
	#print("shooting!")
