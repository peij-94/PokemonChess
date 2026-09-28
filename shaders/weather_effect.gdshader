shader_type canvas_item;

uniform int weather_type : hint_range(0, 4) = 0; // 0=none, 1=sun, 2=rain, 3=sandstorm, 4=snow
uniform float intensity : hint_range(0.0, 1.0) = 0.85;

// Hash noise function
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

void fragment() {
    vec2 uv = UV;
    vec4 col = vec4(0.0);
    float t = TIME;

    if (weather_type == 1) {
        // --- 1. Sun (Harsh Sunlight / Heatwave) ---
        // Warm golden radial sunlight overlay & shimmering heatwave
        float dist = distance(uv, vec2(0.5, 0.0));
        float sun_glow = clamp(1.0 - dist * 1.2, 0.0, 1.0);
        float pulse = 0.85 + 0.15 * sin(t * 2.5);
        vec3 sun_tint = vec3(1.0, 0.65, 0.25) * sun_glow * 0.35 * pulse;
        
        // Heat ripple shimmer
        float shimmer = sin(uv.y * 40.0 + t * 4.0) * 0.02 * sin(uv.x * 20.0);
        col = vec4(sun_tint + vec3(0.08, 0.03, 0.0) * (1.0 + shimmer), (sun_glow * 0.28 + 0.06) * intensity);
    }
    else if (weather_type == 2) {
        // --- 2. Rain (Heavy Rain Streaks) ---
        // Cool blue/cyan rain tint
        vec4 ambient = vec4(0.05, 0.12, 0.22, 0.12 * intensity);
        
        // Fast falling rain slant
        vec2 r_uv = vec2(uv.x * 35.0 - uv.y * 12.0, uv.y * 60.0 + t * 24.0);
        float r_hash = hash(floor(r_uv));
        float drop = step(0.92, r_hash) * fract(r_uv.y);
        drop = pow(drop, 4.0);
        
        col = ambient + vec4(0.65, 0.82, 1.0, drop * 0.65 * intensity);
    }
    else if (weather_type == 3) {
        // --- 3. Sandstorm (Swirling Desert Dust) ---
        // Amber/ochre sand ambient
        vec4 ambient = vec4(0.55, 0.38, 0.18, 0.18 * intensity);
        
        // Fast horizontal swirling dust waves
        float dust1 = sin(uv.x * 12.0 - t * 8.0 + sin(uv.y * 6.0)) * 0.5 + 0.5;
        float dust2 = cos(uv.x * 18.0 - t * 12.0 - uv.y * 8.0) * 0.5 + 0.5;
        float sand_val = (dust1 * 0.6 + dust2 * 0.4);
        
        col = ambient + vec4(0.75, 0.52, 0.25, sand_val * 0.22 * intensity);
    }
    else if (weather_type == 4) {
        // --- 4. Snow (Gentle Falling Flakes & Cold Vignette) ---
        vec4 ambient = vec4(0.2, 0.3, 0.45, 0.10 * intensity);
        
        // Downward drifting snowflakes
        vec2 s_uv = vec2(uv.x * 25.0 + sin(uv.y * 4.0 + t * 1.5) * 2.0, uv.y * 30.0 + t * 4.0);
        float s_hash = hash(floor(s_uv));
        float flake = step(0.94, s_hash) * (1.0 - distance(fract(s_uv), vec2(0.5)));
        flake = clamp(flake * 2.0, 0.0, 1.0);
        
        col = ambient + vec4(0.92, 0.96, 1.0, flake * 0.85 * intensity);
    }

    COLOR = col;
}
