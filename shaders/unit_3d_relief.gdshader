shader_type canvas_item;

// 2.5D Volumetric Relief & Dynamic Rim Lighting Shader for Pokemon Auto-Chess
// Enhances 3D CGI models and sprite textures with tangible volume, key light, and rim glow.

uniform vec3 light_direction = vec3(-0.45, -0.65, 0.60);
uniform float relief_depth : hint_range(0.5, 6.0) = 1.2;
uniform float key_light_strength : hint_range(0.0, 2.0) = 1.15;
uniform float ambient_light : hint_range(0.0, 1.0) = 0.40;
uniform float rim_strength : hint_range(0.0, 2.0) = 0.50;
uniform vec4 rim_color : source_color = vec4(0.85, 0.92, 1.0, 1.0);
uniform float specular_strength : hint_range(0.0, 2.0) = 0.35;
uniform float specular_shininess : hint_range(2.0, 64.0) = 20.0;
uniform float breathing_amplitude : hint_range(0.0, 2.0) = 0.6;
uniform float breathing_speed : hint_range(0.0, 6.0) = 2.4;

// Hit Flash (Pure white or element tinted impact flash)
uniform float hit_flash : hint_range(0.0, 1.0) = 0.0;
uniform vec4 hit_flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Mana Energy Glow (Full mana aura & ultimate readiness)
uniform float mana_glow : hint_range(0.0, 1.0) = 0.0;
uniform vec4 mana_glow_color : source_color = vec4(0.3, 0.75, 1.0, 1.0);

void vertex() {
	// Subtle 3D breathing micro-bobbing on vertical axis
	float bob = sin(TIME * breathing_speed) * breathing_amplitude;
	VERTEX.y += bob;
}

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	if (base_color.a < 0.05) {
		discard;
	}
	
	// Sample neighborhood to compute 3D normal vector from alpha and luminance
	vec2 ps = TEXTURE_PIXEL_SIZE * relief_depth;
	
	vec4 col_l = texture(TEXTURE, UV - vec2(ps.x, 0.0));
	vec4 col_r = texture(TEXTURE, UV + vec2(ps.x, 0.0));
	vec4 col_u = texture(TEXTURE, UV - vec2(0.0, ps.y));
	vec4 col_d = texture(TEXTURE, UV + vec2(0.0, ps.y));
	
	// Calculate height map from alpha and luminance
	float lum_c = dot(base_color.rgb, vec3(0.299, 0.587, 0.114)) * base_color.a;
	float lum_l = dot(col_l.rgb, vec3(0.299, 0.587, 0.114)) * col_l.a;
	float lum_r = dot(col_r.rgb, vec3(0.299, 0.587, 0.114)) * col_r.a;
	float lum_u = dot(col_u.rgb, vec3(0.299, 0.587, 0.114)) * col_u.a;
	float lum_d = dot(col_d.rgb, vec3(0.299, 0.587, 0.114)) * col_d.a;
	
	// Normal vectors in tangent space
	float dx = (lum_l - lum_r) + (col_l.a - col_r.a) * 0.8;
	float dy = (lum_u - lum_d) + (col_u.a - col_d.a) * 0.8;
	vec3 normal = normalize(vec3(dx, dy, 0.85));
	
	// Normalized light and view vectors
	vec3 L = normalize(light_direction);
	vec3 V = vec3(0.0, 0.0, 1.0);
	
	// 1. Diffuse lighting from key light
	float NdotL = max(0.0, dot(normal, L));
	float diffuse = ambient_light + NdotL * (key_light_strength - ambient_light);
	
	// 2. Fresnel rim lighting along 3D silhouette
	float fresnel = pow(1.0 - max(0.0, dot(normal, V)), 2.5);
	vec3 rim = rim_color.rgb * fresnel * rim_strength;
	
	// 3. Specular highlight for toy/figurine finish
	vec3 H = normalize(L + V);
	float NdotH = max(0.0, dot(normal, H));
	float spec = pow(NdotH, specular_shininess) * specular_strength;
	
	// Combine final shading
	vec3 shaded_rgb = base_color.rgb * diffuse + rim * 0.35 + vec3(spec);
	
	// Mana Energy Glow (Pulsating edge aura)
	if (mana_glow > 0.0) {
		shaded_rgb += mana_glow_color.rgb * mana_glow * (0.35 + 0.35 * fresnel);
	}
	
	// Hit Flash (White-hot damage reaction)
	if (hit_flash > 0.0) {
		shaded_rgb = mix(shaded_rgb, hit_flash_color.rgb, hit_flash);
	}
	
	COLOR = vec4(shaded_rgb, base_color.a);
}
