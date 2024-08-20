extends GPUParticles2D

func _ready() -> void:
	var half_viewport_size = get_viewport_rect().size.x/2
	position.x = half_viewport_size
	(self.process_material as ParticleProcessMaterial).emission_sphere_radius = half_viewport_size
