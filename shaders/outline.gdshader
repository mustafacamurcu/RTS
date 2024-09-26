shader_type canvas_item;

uniform bool highlight_enabled = false;

void fragment() {
	float thickness = 2.0;
	if (highlight_enabled) {
		float surrounding_fullness = 0.;
		vec2 size = TEXTURE_PIXEL_SIZE*thickness;
		for (int i = -1; i < 2; i++) {
			for (int j = -1; j < 2; j++) {
				if (i==0 && j==0) {
					continue;
				}
				vec2 offset = size * vec2(float(i), float(j));
				float a = texture(TEXTURE,UV + offset).a;
				if (a > 0.5) {
					surrounding_fullness += texture(TEXTURE,UV + offset).a;
				}
			}
		}
		float borderness = min(1.0, surrounding_fullness);
		COLOR = mix(COLOR,vec4(1.0,0.2,0.2,1.0), borderness-texture(TEXTURE, UV).a);
	}
}