shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float toon_levels : hint_range(2.0, 12.0) = 4.0;
uniform float toon_strength : hint_range(0.0, 1.0) = 0.7;


void fragment() {

    vec3 color = texture(screen_texture, SCREEN_UV).rgb;

    // Convert to brightness
    float brightness = dot(
        color,
        vec3(0.299, 0.587, 0.114)
    );

    // Quantize brightness
    float toon_brightness =
        floor(brightness * toon_levels) / toon_levels;

    // Avoid division by zero
    float ratio =
        toon_brightness / max(brightness, 0.001);

    vec3 toon_color = color * ratio;

    // Blend between original and toon
    color = mix(
        color,
        toon_color,
        toon_strength
    );

    COLOR = vec4(color, 1.0);
}