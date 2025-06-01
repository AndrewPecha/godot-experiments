shader_type spatial;

render_mode cull_disabled;

uniform vec4 color_a: source_color;
uniform vec4 color_b: source_color;

void vertex() {
}

void fragment() {
	//ALBEDO = vec3(VERTEX.x, VERTEX.x, VERTEX.x);
	//lerp is mix()
	//vec2 t = vec2( cos( UV.x * TAU * 2.0 ) * .5 + .5, cos( UV.y * TAU * 2.0 ) * .5 + .5);

	if ( UV.y < 0.5 ) {
		discard;
	}

	float xOffset = cos( UV.x * TAU * 8.0 ) * 0.01;
	float t = cos(( UV.y + xOffset + ( TIME * .1 ) ) * TAU * 5.0) * .5 + .5;

	//t = t * (1.0 - UV.y);

	vec4 gradient = mix(color_a, color_b, t);

	ALBEDO = gradient.xyz;
	ALPHA = gradient.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
