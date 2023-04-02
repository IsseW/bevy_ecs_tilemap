#import bevy_ecs_tilemap::common

struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    #import bevy_ecs_tilemap::vertex_output
}

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    #ifdef ATLAS
    let half_texture_pixel_size_u = 0.5 / tilemap_data.texture_size.x;
    let half_texture_pixel_size_v = 0.5 / tilemap_data.texture_size.y;
    let half_tile_pixel_size_u = 0.5 / tilemap_data.tile_size.x;
    let half_tile_pixel_size_v = 0.5 / tilemap_data.tile_size.y;

    // Offset the UV 1/2 pixel from the sides of the tile, so that the sampler doesn't bleed onto
    // adjacent tiles at the edges.
    var uv_offset: vec2<f32> = vec2<f32>(0.0, 0.0);
    if (in.uv.z < half_tile_pixel_size_u) {
        uv_offset.x = half_texture_pixel_size_u;
    } else if (in.uv.z > (1.0 - half_tile_pixel_size_u)) {
        uv_offset.x = - half_texture_pixel_size_u;
    }
    if (in.uv.w < half_tile_pixel_size_v) {
        uv_offset.y = half_texture_pixel_size_v;
    } else if (in.uv.w > (1.0 - half_tile_pixel_size_v)) {
        uv_offset.y = - half_texture_pixel_size_v;
    }

    let color = textureSample(sprite_texture, sprite_sampler, in.uv.xy + uv_offset) * in.color;
    if (color.a < 0.001) {
        discard;
    }
    #else
    let color = textureSample(sprite_texture, sprite_sampler, in.uv.xy, in.tile_id) * in.color;
    if (color.a < 0.001) {
        discard;
    }
    #endif

    #ifdef LIGHTS
    var light = lights.sky_light;
    for (var i = u32(0); i < min(lights.point_light_count, 256); i += 1) {
        let d = lights.point_lights[i].pos - in.world_position;
        let dist = dot(d, d);
        light += lights.point_lights[i].color * pow((1.0 / dist), lights.point_lights[i].falloff);
    }
    let final_color = color * light;
    #else
    let final_color = color;
    #endif

    return final_color;
}