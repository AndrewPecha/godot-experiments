shader_type spatial;
render_mode world_vertex_coords;

uniform vec4 color_a: source_color;
uniform vec4 color_b: source_color;

float get_wave( vec2 uv ) {
	vec2 foo =  vec2(uv.x * 2.0 - 1.0, uv.y * 2.0 - 1.0);
	
	float radial_distance = length( foo );
	
	float wave = cos((radial_distance - TIME * .1) * TAU * 5.0) * .5 + .5;
	
	return wave;
}

void vertex() {
	//float wave = cos( (UV.y - TIME * .1) * TAU * 5.0 );
	//VERTEX.y = wave * .051;
	
	//NORMAL = MODEL_NORMAL_MATRIX * NORMAL;
	
	VERTEX.y = get_wave(UV) * .05;
}

void fragment() {
	float wave = get_wave(UV);
	
	ALBEDO = vec3( wave, wave, wave );
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
