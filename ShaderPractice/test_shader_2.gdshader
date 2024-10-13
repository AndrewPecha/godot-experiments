shader_type spatial;
uniform float alpha_input: hint_range(0.0, 1.0, 0.1) = 1.0;

void vertex() {
}

void fragment() {
	//ALBEDO = vec3(VERTEX.x, VERTEX.x, VERTEX.x);
	//lerp is mix()
	//vec2 t = vec2( cos( UV.x * TAU * 2.0 ) * .5 + .5, cos( UV.y * TAU * 2.0 ) * .5 + .5);
	
	
	float xOffset = cos( UV.x * TAU * 8.0 ) * 0.01;
	float t = cos(( UV.y + xOffset + ( TIME * .1 ) ) * TAU * 5.0) * .5 + .5;
	
	ALBEDO = vec3(t, t, t);
	ALPHA = alpha_input;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
