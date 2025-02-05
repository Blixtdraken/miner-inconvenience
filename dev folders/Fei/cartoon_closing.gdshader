shader_type canvas_item;
uniform float radius: hint_range(0.0, 1.0, 0.01);
uniform float pixSize = 10.0;
void fragment() {
	vec2 res = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 world  = SCREEN_UV / SCREEN_PIXEL_SIZE;
    vec2 center = 0.5 / SCREEN_PIXEL_SIZE;
    world = round (world / pixSize) * pixSize;
	COLOR.rgb = vec3(0.0);
    COLOR.a = step(radius*length(res)/2.0, length(world-center));
}