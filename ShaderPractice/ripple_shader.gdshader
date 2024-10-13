shader_type spatial;
render_mode world_vertex_coords;

uniform vec4 color_a: source_color;
uniform vec4 color_b: source_color;

void vertex() {
	float wave = cos( (UV.y - TIME * .1) * TAU * 5.0 );
	VERTEX.y = wave * .051;
	
	//NORMAL = MODEL_NORMAL_MATRIX * NORMAL;
}

void fragment() {
	//ALBEDO = vec3(VERTEX.x, VERTEX.x, VERTEX.x);
	//lerp is mix()
	//vec2 t = vec2( cos( UV.x * TAU * 2.0 ) * .5 + .5, cos( UV.y * TAU * 2.0 ) * .5 + .5);
	
	//ALBEDO = vec3(UV.y, UV.x, 0);

	float t = cos ( ( UV.y - TIME * 0.1 ) * TAU * 5.0 ) * 0.5 + 0.5;
	//t = t * (1.0 - UV.y);
	
	ALBEDO = vec3(t, t, t);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
