use bevy::{prelude::{Color, Component, Bundle, Visibility, Transform, GlobalTransform, ComputedVisibility}, reflect::Reflect};

#[derive(Component, Copy, Clone, Debug, Reflect)]
pub struct Skylight2d {
    pub color: Color,
    pub strength: f32,
}

impl Default for Skylight2d {
    fn default() -> Self {
        Self { color: Color::WHITE, strength: 1.0 }
    }
}

#[derive(Component, Copy, Clone, Debug, Reflect)]
pub struct PointLight2d {
    pub color:  Color,
    pub strength: f32,
    pub falloff: f32,
}

impl Default for PointLight2d {
    fn default() -> Self {
        Self { color: Color::WHITE, strength: 1.0, falloff: 1.0 }
    }
}

#[derive(Bundle, Default)]
pub struct PointLight2dBundle {
    pub light: PointLight2d,
    pub transform: Transform,
    pub global_transform: GlobalTransform,
    /// Enables or disables the light
    pub visibility: Visibility,
    /// Algorithmically-computed indication of whether an entity is visible and should be extracted for rendering
    pub computed_visibility: ComputedVisibility,
}