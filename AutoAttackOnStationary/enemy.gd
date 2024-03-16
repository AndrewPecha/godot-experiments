extends Area2D
signal enemy_death

@export var projectile: PackedScene

var max_health: int = 5
var current_health: int
var player: Node2D
var attack_cooldown: float = 0.5
var attack_cooldown_counter: float = 0.0

var is_idling: bool = true
var is_moving: bool = false
var idle_timeout: float = 1.0
var move_timeout: float = 1.0
var state_counter: float = 0.0
var speed: float = 1.0
var direction_to_move: Vector2

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	current_health = max_health
	
	($HealthBar/ProgressBar as ProgressBar).max_value = max_health
	set_health_bar_value()
	player = get_tree().root.get_node("./World/Player")
	var world = get_tree().root.get_node("./World")
	enemy_death.connect(world.enemy_died)

func _physics_process(delta: float) -> void:
	attack_cooldown_counter += delta
	state_counter += delta
	
	_attack_player()
	_handle_state()


func _on_area_entered(area: Area2D) -> void:
	current_health -= 1
	set_health_bar_value()
	
	if current_health <= 0:
		enemy_death.emit()
		queue_free()

func _handle_state():
	#pick direction
	if is_idling and state_counter >= idle_timeout:
		state_counter = 0.0
		is_idling = false
		is_moving = true
		var x = rng.randf_range(-1.0, 1.0)
		var y = rng.randf_range(-1.0, 1.0)
		direction_to_move = Vector2(x, y).normalized()
		
	elif is_moving and state_counter >= move_timeout:
		state_counter = 0.0
		is_idling = true
		is_moving = false
	
	#move in direction
	if is_moving:
		position += direction_to_move * speed

func _attack_player():
	if attack_cooldown_counter >= attack_cooldown:
		attack_cooldown_counter = 0.0
	
		var projectile_instance = projectile.instantiate()
		var target_direction = (player.global_position - global_position).normalized()
		projectile_instance.direction = target_direction
		projectile_instance.global_position = global_position
		get_tree().root.get_node("World").add_child(projectile_instance)
		print("attacking " + player.name)

func set_health_bar_value():
	($HealthBar/ProgressBar as ProgressBar).value = current_health
	($HealthBar/Label as Label).text = str(($HealthBar/ProgressBar as ProgressBar).value)
