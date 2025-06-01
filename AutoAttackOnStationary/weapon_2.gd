extends Area2D

@export var weapon_radius: float = 50.0
@export var swing_speed: float = 4.0  # Swings per second
@export var swing_arc_degrees: float = 30.0
@export var hit_flash_duration: float = 0.1
@export var rotation_speed: float = 10.0  # How fast the weapon rotates to face target

var target: Node2D
var base_rotation: float = 0.0
var current_swing_time: float = 0.0
var flash_time: float = 0.0

func _physics_process(delta: float) -> void:
	target = find_closest_enemy()
	if target:
		# Calculate desired rotation to face target
		var target_direction = (target.global_position - global_position).normalized()
		var desired_rotation = Vector2.RIGHT.angle_to(target_direction)
		
		# Smoothly rotate the base rotation towards the target
		base_rotation = lerp_angle(base_rotation, desired_rotation, rotation_speed * delta)
		
		# Update position to maintain fixed radius from player
		position = target_direction * weapon_radius
		
		# Calculate swing offset using sine wave
		current_swing_time += delta * swing_speed * PI
		var swing_offset = sin(current_swing_time) * deg_to_rad(swing_arc_degrees / 2)
		
		# Apply final rotation
		rotation = base_rotation + swing_offset
	
	# Handle hit flash effect
	if flash_time > 0:
		flash_time -= delta
		modulate = Color.RED.lerp(Color.WHITE, 1.0 - (flash_time / hit_flash_duration))
	else:
		modulate = Color.WHITE

func find_closest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("Enemy")
	var closest_enemy: Node2D
	var closest_enemy_distance: float
	
	for enemy in enemies:
		var distance_from_player = global_position.distance_to(enemy.global_position)
		if distance_from_player < closest_enemy_distance || closest_enemy_distance == 0:
			closest_enemy = enemy
			closest_enemy_distance = distance_from_player
	
	return closest_enemy

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		flash_time = hit_flash_duration