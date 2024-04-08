extends Node2D

@export var projectile: PackedScene
var shoot_cooldown_timeout: float = 1.0
var shoot_cooldown_counter: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	shoot_cooldown_counter += delta
	if shoot_cooldown_counter >= shoot_cooldown_timeout:
		shoot()
		shoot_cooldown_counter = 0
		
func shoot() -> void:
	var shot_direction = Vector2(1, 0)
	var projectile_instance = projectile.instantiate()
	projectile_instance.direction = shot_direction
	add_child(projectile_instance)
	
	#print("shooting!")
