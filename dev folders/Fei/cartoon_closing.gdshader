shader_type canvas_item;

uniform float amount:hint_range(0.0, 1.0, 0.01);
uniform vec2 sprite_resulotion;

void fragment() {
	vec2 center = vec2(0.5);
	//COLOR = vec4(TEXTURE_PIXEL_SIZE*vec2(textureSize(TEXTURE, 0)).xy, 0.5, 1.0);
	vec2 snapped_uv = round(UV*sprite_resulotion-TEXTURE_PIXEL_SIZE*(sprite_resulotion/2.0));
	//COLOR = vec4(vec3(snapped_uv.x* 1.0/sprite_resulotion.x), 1.0);
	COLOR = COLOR * vec4(vec3(1.0),distance(center, snapped_uv));
}
