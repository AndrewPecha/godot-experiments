extends CharacterBody2D

const SPEED = 300.0
var is_dragging: bool
var mouse_hovering: bool

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left_click") && is_dragging:
		move_to_mouse()
		
	elif !Input.is_action_pressed("left_click"):
		is_dragging = false
		
func move_to_mouse():
	global_position = get_global_mouse_position()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and mouse_hovering:
		is_dragging = true


func _on_mouse_entered() -> void:
	mouse_hovering = true


func _on_mouse_exited() -> void:
	mouse_hovering = false
