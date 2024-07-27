extends StaticBody2D

@export var marker: PackedScene
@export var speed: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var marker_instance = marker.instantiate()
	marker_instance.global_position = Vector2(global_position.x, global_position.y - 200)
	get_tree().root.get_node("World").add_child.call_deferred(marker_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
