shader_type spatial;

uniform float height_scale = 0.05;
uniform sampler2D distortion_sampler;
uniform sampler2D texture_sampler;
uniform float distortion_factor: hint_range(0.0, 1.0, 0.05) = 0.5;

varying vec2 tex_position;

void vertex() {
	vec4 displace = texture(distortion_sampler, UV);
	vec3 new_vertex = vec3(0, displace.y * .05 , 0) + VERTEX;
	//
	//VERTEX = new_vertex;
	//NORMAL = new_vertex;
	
	
	//float wave = cos( (UV.y - TIME * .1) * TAU * 5.0 );
	//
	//UV.x += wave * .003;
	//UV.y += wave * .002;
}

void fragment() {
	vec2 noise_uv = UV + TIME * .1;
	vec2 noise = vec2(texture(distortion_sampler, noise_uv).xx);
	vec2 base_uv = UV + noise * distortion_factor;
	ALBEDO = texture(texture_sampler, base_uv).xyz;
	
	//ALBEDO = texture(texture_sampler, UV).xyz;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
