#define_import_path bevy_ecs_tilemap::vertex_output

@location(0) uv: vec4<f32>,
@location(1) color: vec4<f32>,
@location(2) @interpolate(flat) tile_id: i32,
#ifdef LIGHTS
@location(3) world_position: vec4<f32>,
#endif