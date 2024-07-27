extends StaticBody2D

@export var marker: PackedScene
@export var speed: float = 5.0
var marker_instance: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	marker_instance = marker.instantiate()
	marker_instance.global_position = Vector2(global_position.x, global_position.y - 200)
	get_tree().root.get_node("World").add_child.call_deferred(marker_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction_to_marker:Vector2 = (marker_instance.global_position - global_position)
	var new_marker_position = direction_to_marker.normalized().rotated(deg_to_rad(20 * delta)) * direction_to_marker.length()
	marker_instance.global_position = global_position + new_marker_position
