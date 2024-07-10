class_name FarmPlot
extends Area2D

var has_been_visited: bool = false
var farmer_touching: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click") && farmer_touching:
		$Sprite.modulate = Color.GREEN

func set_visited_status(status: bool):
	has_been_visited = status


func _on_body_entered(body: Node2D) -> void:
	if body is Farmer:
		farmer_touching = true


func _on_body_exited(body: Node2D) -> void:
	if body is Farmer:
		farmer_touching = false
