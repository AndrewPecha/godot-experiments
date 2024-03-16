extends Control

var current_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increment_score(score_increase: int):
	current_score += score_increase
	$HBoxContainer/Score.text = str(current_score)
