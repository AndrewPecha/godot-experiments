extends Control

@export var player: Farmer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture_rects = $Menu.get_children()
	for rect in texture_rects:
			if rect.get_node('ColorRect').visible:
				player.set_skill(rect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released('scroll_down'):
		var texture_rects = $Menu.get_children()
		for x in len(texture_rects):
			var rect = texture_rects[x]
			#rect.get_node('ColorRect').visible = !rect.get_node('ColorRect').visible
			if rect.get_node('ColorRect').visible:
				var next_skill_index = x + 1
				if next_skill_index == len(texture_rects):
					next_skill_index = 0
				var next_skill = texture_rects[next_skill_index]
				rect.get_node('ColorRect').visible = false
				next_skill.get_node('ColorRect').visible = true
				player.set_skill(next_skill)
				return
				
	if event.is_action_released('scroll_up'):
		var texture_rects = $Menu.get_children()
		for x in len(texture_rects):
			var rect = texture_rects[x]
			#rect.get_node('ColorRect').visible = !rect.get_node('ColorRect').visible
			if rect.get_node('ColorRect').visible:
				var next_skill_index = x - 1
				if next_skill_index == -1:
					next_skill_index = len(texture_rects) - 1
				var next_skill = texture_rects[next_skill_index]
				rect.get_node('ColorRect').visible = false
				next_skill.get_node('ColorRect').visible = true
				player.set_skill(next_skill)
				return
