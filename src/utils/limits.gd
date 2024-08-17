extends Area2D

func _ready():
	self.area_exited.connect(_handle_area_exited)

func _handle_area_exited(area: Area2D):
	if area as Projectile:
		area.call_deferred("_destroy")
