extends Node3D
class_name PlaceholderProjectile

var shot_direction: Vector3
const SPEED = 8

var bezier_speed: float = 2.0
var deviation_distance: float = 5
var deviation_angle: float = 90

var p0: Vector3
var p1: Vector3
var p2: Vector3

var t: float = 0.0

func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#position += shot_direction * SPEED * delta
	
	#if t >= 1.0:
		#queue_free()
		#return
	
	if t < 1.0:
		t += bezier_speed * delta
		
	if t > 1.0:
		t = 1.0
		
	position = _quadratic_bezier(p0, p1, p2, t)

# lots of code modified from https://www.youtube.com/watch?v=4SHqHFWYg-s&t=106s
func set_destination(destination):
	p0 = global_position
	p2 = destination
	
	var tilted_unit_vector = (p2-p0).normalized().rotated(Vector3(0, 1, 0), deg_to_rad(-deviation_angle))
	print("tilted vector: " + str(tilted_unit_vector))
	p1 = p0 + deviation_distance * tilted_unit_vector
	
	call_deferred("set_physics_process", true)

func _quadratic_bezier(p0: Vector3, p1: Vector3, p2: Vector3, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
