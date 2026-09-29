shader_type canvas_item;

// Toon / Cel-Shading Post-Processing Shader for 3D Auto-Chess
// Features:
// 1. Anime Black Ink Silhouette Outline (Sobel / Edge Detection)
// 2. Cel-Shaded Color Quantization (Discrete Tone Bands)
// 3. Stylized Color Vibrancy & Saturation Boost for Anime Pop

uniform float outline_thickness : hint_range(0.5, 4.0) = 1.2;
uniform vec4 outline_color : source_color = vec4(0.06, 0.07, 0.10, 1.0);
uniform float outline_threshold : hint_range(0.05, 0.6) = 0.14;
uniform float color_bands : hint_range(3.0, 16.0) = 8.0;
uniform float saturation_boost : hint_range(1.0, 1.8) = 1.22;
uniform float contrast_boost : hint_range(1.0, 1.5) = 1.10;

void fragment() {
	vec2 ps = SCREEN_PIXEL_SIZE * outline_thickness;
	vec4 base_color = texture(TEXTURE, UV);
	
	// Sample 4-way cross neighborhood for edge detection
	vec3 c_u = texture(TEXTURE, UV + vec2(0.0, -ps.y)).rgb;
	vec3 c_d = texture(TEXTURE, UV + vec2(0.0, ps.y)).rgb;
	vec3 c_l = texture(TEXTURE, UV + vec2(-ps.x, 0.0)).rgb;
	vec3 c_r = texture(TEXTURE, UV + vec2(ps.x, 0.0)).rgb;
	
	// Calculate color difference gradient
	vec3 delta_h = c_r - c_l;
	vec3 delta_v = c_d - c_u;
	float edge = length(delta_h) + length(delta_v);
	
	// Cel-shaded color quantization (banding into discrete anime shades)
	vec3 cel_rgb = floor(base_color.rgb * color_bands + 0.5) / color_bands;
	
	// Saturation & Contrast enhancement for vibrant anime look
	float gray = dot(cel_rgb, vec3(0.299, 0.587, 0.114));
	cel_rgb = mix(vec3(gray), cel_rgb, saturation_boost);
	cel_rgb = (cel_rgb - 0.5) * contrast_boost + 0.5;
	cel_rgb = clamp(cel_rgb, 0.0, 1.0);
	
	// Composite comic outline
	if (edge > outline_threshold) {
		float edge_factor = smoothstep(outline_threshold, outline_threshold * 1.6, edge);
		COLOR = vec4(mix(cel_rgb, outline_color.rgb, edge_factor), base_color.a);
	} else {
		COLOR = vec4(cel_rgb, base_color.a);
	}
}
