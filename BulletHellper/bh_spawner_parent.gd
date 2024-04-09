extends Node2D

@export var rotate_self: bool
@export var full_rotation_time: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if rotate_self:
		rotate(2 * PI * (delta / full_rotation_time))
