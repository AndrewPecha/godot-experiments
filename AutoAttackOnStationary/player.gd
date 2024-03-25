extends CharacterBody2D
signal player_died

const SPEED = 300.0
var is_moving: bool

var max_health: int = 10
var current_health: int

func _ready():
	current_health = max_health
	
	($HealthBar/ProgressBar as ProgressBar).max_value = max_health
	set_health_bar_value()

func _physics_process(delta: float) -> void:	
	handle_movement()

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

func set_health_bar_value():
	($HealthBar/ProgressBar as ProgressBar).value = current_health
	($HealthBar/Label as Label).text = str(($HealthBar/ProgressBar as ProgressBar).value)

func damage_player(damage_amount: int):
	current_health -= damage_amount
	set_health_bar_value()
	if current_health <= 0:
		player_died.emit()
