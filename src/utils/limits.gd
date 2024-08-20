extends Area2D

@export var shape: CollisionShape2D
@export var adjust_shape_to_viewport: bool

func _ready():
	self.area_exited.connect(_handle_area_exited)
	if adjust_shape_to_viewport and shape:
		var viewport_size_shape = RectangleShape2D.new()
		viewport_size_shape.size = get_viewport_rect().size
		shape.shape = viewport_size_shape

func _handle_area_exited(area: Area2D):
	if area as Projectile:
		area.call_deferred("_destroy")
