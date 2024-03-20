extends CharacterBody2D


const SPEED = 300.0
const DASH_DISTANCE = 200.0
var is_dashing: bool = false
var dash_target: Vector2


func _physics_process(delta: float) -> void:
	if !is_dashing:
		handle_movement()
	
	#if is_dashing && global_position == dash_target:
		#is_dashing = false

	

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

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rmb") && !is_dashing:
		dash()

func dash() -> void:
	is_dashing = true
	dash_target = (get_global_mouse_position() - global_position).normalized() * DASH_DISTANCE
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", dash_target + global_position, 0.15)
	tween.tween_callback(func(): is_dashing = false)
	
