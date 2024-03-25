extends Sprite2D

@export var projectile: PackedScene
var target: Node2D
var attack_cooldown: float = 0.2
var attack_cooldown_counter: float = 0.0
var is_moving: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	attack_cooldown_counter += delta
	
	target = find_closest_enemy()
	handle_weapon_rotation()
	
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	is_moving = direction_x || direction_y
	
	if !is_moving:
		attack()

func fire(target_direction: Vector2):
	var projectile_instance = projectile.instantiate()
	projectile_instance.direction = target_direction
	projectile_instance.global_position = $ProjectileSpawn.global_position
	get_tree().root.get_node("World").add_child(projectile_instance)

func handle_weapon_rotation():
	if target == null:
		return
		
	var target_direction = (target.global_position - global_position).normalized()
	var weapon_position = target_direction * 50
	position = weapon_position
	
	rotation = Vector2.RIGHT.angle_to(target_direction)

func attack() -> void:
	if attack_cooldown_counter >= attack_cooldown:
		attack_cooldown_counter = 0.0
		
		if target == null:
			return
		
		var target_direction = (target.global_position - global_position).normalized()
		fire(target_direction)
		print("attacking " + target.name)

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
