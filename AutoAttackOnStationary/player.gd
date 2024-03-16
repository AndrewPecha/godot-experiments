extends CharacterBody2D
signal player_died

const SPEED = 300.0
var is_moving: bool

var attack_cooldown: float = 0.2
var attack_cooldown_counter: float = 0.0
var target: Node2D

var max_health: int = 10
var current_health: int

func _ready():
	current_health = max_health
	
	($HealthBar/ProgressBar as ProgressBar).max_value = max_health
	set_health_bar_value()

func _physics_process(delta: float) -> void:
	attack_cooldown_counter += delta
	
	target = find_closest_enemy()
	handle_movement()
	handle_weapon_rotation()
	
	if !is_moving:
		attack()

func handle_movement() -> void:
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = direction_y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	velocity = velocity.normalized() * SPEED

	if velocity == Vector2(0, 0):
		is_moving = false
		
	else:
		is_moving = true

	move_and_slide()

func handle_weapon_rotation():
	if target == null:
		return
		
	var target_direction = (target.global_position - global_position).normalized()
	var weapon_position = target_direction * 50
	$Weapon.position = weapon_position
	
	$Weapon.rotation = Vector2.RIGHT.angle_to(target_direction)
	
func attack() -> void:
	if attack_cooldown_counter >= attack_cooldown:
		attack_cooldown_counter = 0.0
		
		if target == null:
			return
		
		var target_direction = (target.global_position - global_position).normalized()
		$Weapon.fire(target_direction)
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

func set_health_bar_value():
	($HealthBar/ProgressBar as ProgressBar).value = current_health
	($HealthBar/Label as Label).text = str(($HealthBar/ProgressBar as ProgressBar).value)

func damage_player(damage_amount: int):
	current_health -= damage_amount
	set_health_bar_value()
	if current_health <= 0:
		player_died.emit()
