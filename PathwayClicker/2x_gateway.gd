extends Area3D

var rng = RandomNumberGenerator.new()
var gateway_id = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gateway_id = rng.randi_range(0, 99999)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is Friendly and not (body as Friendly).gateways_used.has(gateway_id):
		var new_node = body.duplicate()
		new_node.position.x = new_node.position.x - .2
		get_tree().root.get_node("World").add_child(new_node)
		print("UNACCEPTABRU")
		body.gateways_used.append(gateway_id)
		new_node.gateways_used.append(gateway_id)
