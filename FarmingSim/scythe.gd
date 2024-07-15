extends Skill


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skill_name = "scythe"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func perform_action() -> void:
	print("scything")
