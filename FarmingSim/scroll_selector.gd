extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released('scroll_down'):
		var texture_rects = get_children()
		for rect in texture_rects:
			rect.get_node('ColorRect').visible = !rect.get_node('ColorRect').visible
