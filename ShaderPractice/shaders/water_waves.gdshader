shader_type spatial;

uniform float height_scale = 0.05;
uniform sampler2D distortion_sampler;
uniform sampler2D texture_sampler;
uniform float distortion_factor: hint_range(0.0, 1.0, 0.01) = 0.5;

varying vec2 tex_position;

void vertex() {
	//vec4 displace = texture(distortion_sampler, UV);
	//vec3 new_vertex = vec3(0, displace.y * .05 , 0) + VERTEX;
	//
	//VERTEX = new_vertex;
	//NORMAL = new_vertex;
	
	
	//float wave = cos( (UV.y - TIME * .1) * TAU * 5.0 );
	//
	//UV.x += wave * .003;
	//UV.y += wave * .002;
}

void fragment() {
	//choose a uv based on how much TIME has passed
	//multiply TIME by time_factor to slow down the animation
	
	//input = (.2, .2)
	float time_factor = 0.1;
	vec2 noise_uv = UV + TIME * time_factor;
	//noise_uv = (.2, .2) + 1.0 * 0.1 == (.3, .3)
	
	
	//read from the distortion_sample using the UV chosen with our calculation above
	//black on the distortion sampler will return 0
	//white on the distortion sampler will return 1 
	//noise_value = ((value of color.x at (.2, .2)), -(value of color.x at (.2, .2)))
	//noise_value = (1, -1)
	vec2 noise_value = vec2(texture(distortion_sampler, noise_uv).x, -texture(distortion_sampler, noise_uv).x);
	
	//base_UV offsets where we read the texture from
	//the offset is greater in areas with white for the distortion texture
	//base_uv = (.2, .2) + ((1, -1) * .2)
	//base_uv = (.2, .2) + (.2, -.2)
	//base_uv = (.4, 0)
	vec2 base_uv = UV + noise_value * distortion_factor;
	ALBEDO = texture(texture_sampler, base_uv).xyz;
	
	//ALBEDO = vec3(base_uv, 0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
