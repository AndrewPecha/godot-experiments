extends Node3D
class_name PlaceholderProjectile

@export var bezier_marker: PackedScene

var shot_direction: Vector3

var bezier_speed: float = 1.0
var deviation_distance: float = 5
var deviation_angle: float = 90

var p0: Vector3
var p1: Vector3
var p2: Vector3
var p3: Vector3

var t: float = 0.0

var markers: Array

func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:	
	if t < 1.0:
		t += bezier_speed * delta
		
	if t > 1.0:
		t = 1.0
		
	#position = _quadratic_bezier(p0, p1, p2, t)
	position = _cubic_bezier()
	
	if t >= 1.0:
		queue_free()
		for x in markers:
			x.queue_free()

# lots of code modified from https://www.youtube.com/watch?v=4SHqHFWYg-s&t=106s
func set_destination(destination):
	p0 = global_position
	p2 = destination
	
	var tilted_unit_vector = (p2-p0).normalized().rotated(Vector3(0, 1, 0), deg_to_rad(-deviation_angle))
	print("tilted vector: " + str(tilted_unit_vector))
	p1 = p0 + deviation_distance * tilted_unit_vector
	
	call_deferred("set_physics_process", true)
	
func set_destination_cubic(init_position: Vector3, destination: Vector3, p1_angle: float, p2_angle: float, p1_distance: float):
	p0 = init_position
	p1 = (destination - p0).normalized().rotated(Vector3(0, 1, 0), deg_to_rad(-p1_angle)).normalized()
	p1.y = init_position.y
	p2 = (destination - p0).normalized().rotated(Vector3(0, 1, 0), deg_to_rad(-p2_angle)).normalized()
	p2.y = destination.y
	p3 = destination
	
	#print("p0: " + str(p0))
	#print("p1: " + str(p1))
	#print("p2: " + str(p2))
	#print("p3: " + str(p3))
	call_deferred("_draw_points")
	
	call_deferred("set_physics_process", true)

func _draw_points() -> void:
	var p0_marker = bezier_marker.instantiate()
	var p1_marker = bezier_marker.instantiate()
	var p2_marker = bezier_marker.instantiate()
	var p3_marker = bezier_marker.instantiate()
	
	p0_marker.position = p0
	p1_marker.position = p1
	p2_marker.position = p2
	p3_marker.position = p3
	
	var newMaterial = StandardMaterial3D.new()
	newMaterial.albedo_color = Color.RED
	p1_marker.get_node("MeshInstance3D").material_override = newMaterial
	
	var newMaterial2 = StandardMaterial3D.new()
	newMaterial2.albedo_color = Color.GREEN
	p2_marker.get_node("MeshInstance3D").material_override = newMaterial2
	
	get_tree().root.get_node("World").add_child(p0_marker)
	get_tree().root.get_node("World").add_child(p1_marker)
	get_tree().root.get_node("World").add_child(p2_marker)
	get_tree().root.get_node("World").add_child(p3_marker)
	
	markers.append(p0_marker)
	markers.append(p1_marker)
	markers.append(p2_marker)
	markers.append(p3_marker)

#bezier functions made from https://docs.godotengine.org/en/stable/tutorials/math/beziers_and_curves.html
func _quadratic_bezier():
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func _cubic_bezier():
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)

	var s = r0.lerp(r1, t)
	return s
