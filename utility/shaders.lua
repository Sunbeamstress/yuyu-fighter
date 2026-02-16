game.shader = {}
game.shader_timer = 0



local shader_code = [[
extern float shader_timer;
extern float screen_width;

const vec3 SHINE1 = vec3(254.0/255.0);
const vec3 SHINE2 = vec3(253.0/255.0);
const vec3 SHINE3 = vec3(252.0/255.0);

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec4 pixel = Texel(tex, texture_coords) * color;
    float x = screen_coords.x / screen_width;

    if (pixel.rgb == SHINE1) {
        vec3 base_color = vec3(1.0, 0.0, 1.0);
        float shine_pos = mod(shader_timer, 1.0);
        float dist = abs(x - shine_pos);
        dist = min(dist, 1.0 - dist);
        float width = 0.1;
        float shine = 1.0 - smoothstep(0.0, width, dist);
        pixel.rgb = mix(base_color, vec3(1.0), shine);

    } else if (pixel.rgb == SHINE2) {
        vec3 base_color = vec3(0.0, 0.2, 0.75);
        float shine_pos = mod(shader_timer * 0.75, 1.0);
        float dist = abs(x - shine_pos);
        dist = min(dist, 1.0 - dist);
        float width = 0.025;
        float shine = 1.0 - smoothstep(0.0, width, dist);
        pixel.rgb = mix(base_color, vec3(1.0), shine);
    } else if (pixel.rgb == SHINE3) {
        vec3 base_color = vec3(0.75, 0.0, 0.35);
        float shine_pos = mod(shader_timer * 0.4, 1.0);
        float dist = abs(x - shine_pos);
        dist = min(dist, 1.0 - dist);
        float width = 0.1;
        float shine = 1.0 - smoothstep(0.0, width, dist);
        pixel.rgb = mix(base_color, vec3(1.0), shine * vec3(-2.0, 0.0, 1.0));
    }

    return pixel;
}
]]



function init_shader()
    game.shader.vertigo_city = love.graphics.newShader(shader_code)
    game.shader.vertigo_city:send("screen_width", game.window.width)
    game.shader.vertigo_city:send("shader_timer", game.shader_timer)

    local x = game.window.width * game.window.ratio
    local y = game.window.height * game.window.ratio
    local xy = x * y
end



function update_shader(dt)
    game.shader_timer = game.shader_timer + dt
    game.shader.vertigo_city:send("shader_timer", game.shader_timer)
end