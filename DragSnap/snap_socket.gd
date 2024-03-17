extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_snap_snap_drag_started() -> void:
	$Perimeter.visible = true


func _on_snap_snap_drag_ended() -> void:
	$Perimeter.visible = false
	if $Perimeter.snap != null:
		$Perimeter.snap.global_position = $Perimeter.get_parent().global_position
