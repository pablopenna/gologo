extends Area2D

func _ready():
	_adjust_collision_shape_to_viewport()
	self.area_exited.connect(_handle_area_exited)

func _handle_area_exited(area: Area2D):
	if area as Projectile: 
		area.call_deferred("_destroy")

func _adjust_collision_shape_to_viewport() -> void:
	var collision_shape = CollisionShape2D.new()
	var viewport_size_shape = RectangleShape2D.new()
	viewport_size_shape.size = get_viewport_rect().size
	collision_shape.shape = viewport_size_shape
	add_child(collision_shape)
