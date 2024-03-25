extends Area2D

var continuous_damage: bool = true
var damage: int = 1
var target: Node2D
var is_moving: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target = find_closest_enemy()
	handle_weapon_rotation()
	
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	is_moving = direction_x || direction_y
	
	if !is_moving:
		attack()

func handle_weapon_rotation():
	if target == null:
		return
		
	var target_direction = (target.global_position - global_position).normalized()
	var weapon_position = target_direction * 50
	position = weapon_position
	
	rotation = Vector2.RIGHT.angle_to(target_direction)

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

func attack() -> void:
		if target == null:
			return
		
		var target_direction = (target.global_position - global_position).normalized()
		print("attacking " + target.name)
