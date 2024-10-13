shader_type spatial;

void vertex() {
}

void fragment() {
	//ALBEDO = vec3(VERTEX.x, VERTEX.x, VERTEX.x);
	//lerp is mix()
	//vec2 t = vec2( cos( UV.x * TAU * 2.0 ) * .5 + .5, cos( UV.y * TAU * 2.0 ) * .5 + .5);
	
	float xOffset = UV.y;
	
	float t = cos(( UV.x + xOffset ) * TAU * 5.0) * .5 + .5;
	ALBEDO = vec3(t, t, t);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
