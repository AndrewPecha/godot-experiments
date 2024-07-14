class_name Farmer
extends CharacterBody2D

var current_plot: FarmPlot
var current_skill: Skill

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	handle_movement()
	#if current_plot == null:
		#current_plot = _find_plot()
	
func _find_plot() -> FarmPlot:
	var farm_plots = get_tree().get_nodes_in_group("FarmPlots")
	var closest_plot: Node2D
	var closest_plot_distance: float
	
	for plot in farm_plots:
		var distance_from_player = global_position.distance_to(plot.global_position)
		if distance_from_player < closest_plot_distance || closest_plot_distance == 0:
			closest_plot = plot
			closest_plot_distance = distance_from_player
	
	return closest_plot

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		current_skill.perform_action()

func handle_movement() -> void:
	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = direction_y
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	velocity = velocity.normalized() * SPEED

	move_and_slide()

func set_skill(skill: Skill) -> void:
	current_skill = skill
