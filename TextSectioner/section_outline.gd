extends Control

var label_width: float
var offset: float = 20.0
var DEFAULT_COLOR: Color = Color.GRAY
var HIGHLIGHT_COLOR: Color = Color.GREEN
var outline_color = DEFAULT_COLOR

# Called when the node enters the scene tree for the first time.
func _ready():
	label_width = (get_node("../SectionLabel") as RichTextLabel).get_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var center = get_rect().size.x / 2
	var left = center - ((label_width / 2) + offset)
	var right = center + ((label_width / 2) + offset)
	draw_line(Vector2(left, 30), Vector2(left, 50), outline_color, 3.0)
	draw_line(Vector2(right, 30), Vector2(right, 50), outline_color, 3.0)
	draw_line(Vector2(left, 50), Vector2(right, 50), outline_color, 3.0)
	draw_line(Vector2(center, 50), Vector2(center, 70), outline_color, 3.0)


func _on_mouse_entered():
	outline_color = HIGHLIGHT_COLOR
	queue_redraw()


func _on_mouse_exited():
	outline_color = DEFAULT_COLOR
	queue_redraw()
