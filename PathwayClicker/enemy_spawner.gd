extends StaticBody3D

@export var enemy: PackedScene
const spawn_cooldown: float = 1.0
var current_cooldown: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_cooldown += delta
	if current_cooldown >= spawn_cooldown:
		current_cooldown = 0
		_spawn_enemy()

func _spawn_enemy() -> void:
		print("spawning enemy")
		var instance = enemy.instantiate() as Node3D
		instance.global_position = global_position
		get_tree().root.get_node("World").add_child(instance)
