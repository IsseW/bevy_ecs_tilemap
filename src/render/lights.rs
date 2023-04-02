use bevy::{render::render_resource::ShaderType, prelude::{Vec2, Vec3, Resource}};


#[derive(Debug, Default, Copy, Clone, ShaderType)]
pub struct PointLight {
    pub pos: Vec2,
    pub color: Vec3,
    pub falloff: f32,
}

#[derive(Debug, Copy, Clone, Resource, ShaderType)]
pub struct LightsUniformData {
    pub skylight: Vec3,
    pub light_count: u32,
    pub lights: [PointLight; 256],
}

impl Default for LightsUniformData {
    fn default() -> Self {
        Self { skylight: Default::default(), light_count: Default::default(), lights: [PointLight::default(); 256] }
    }
}