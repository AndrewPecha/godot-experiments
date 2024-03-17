extends Sprite2D
var color = Color.RED
var snap: Snap = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw() -> void:
	color.a = .2
	var collision_shape = get_node("../CollisionShape2D")
	var radius = ((collision_shape as CollisionShape2D).shape as CircleShape2D).radius
	draw_circle(Vector2(0, 0), radius, color)

func _on_snap_socket_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	color = Color.GREEN
	snap = body
	queue_redraw()


func _on_snap_socket_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	color = Color.RED
	snap = null
	queue_redraw()
