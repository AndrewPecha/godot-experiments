extends Node2D

@export var enemy_to_spawn: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# wait for player node to be done loading
	# connect to player died signal
	get_node("Player").connect("player_died", player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_enemy"):
		var enemy_instance = enemy_to_spawn.instantiate()
		enemy_instance.global_position = get_global_mouse_position()
		add_child(enemy_instance)

func player_died():
	get_tree().paused = true
	$DeathScene.visible = true
	print("You DIED!")

func enemy_died():
	$ScoreKeeper.increment_score(1)
