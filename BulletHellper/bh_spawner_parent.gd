extends Node2D

@export var number_of_spawners: int = 4
@export var rotate_self: bool
@export var full_rotation_time: float = 5.0

@onready var _spawner_scene: PackedScene = preload("res://BulletHellper/bullet_spawner.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rotation_amount: float = (2 * PI) / number_of_spawners
	
	for i in number_of_spawners:
		var spawner_instance: BhSpawner = _spawner_scene.instantiate()
		add_child(spawner_instance)
		spawner_instance.shot_direction = spawner_instance.shot_direction.rotated(rotation_amount * i)
		spawner_instance.projectile = preload("res://BulletHellper/projectile.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rotate_self:
		rotate(2 * PI * (delta / full_rotation_time))
