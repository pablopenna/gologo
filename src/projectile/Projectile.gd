class_name Projectile extends Area2D

@export var direction = Vector2.UP
@export var speed = 100
var hasExploded

signal outOfScreen
signal destroyed # when destroying the projectile via queue_free(), VisibleOnScreenNotifier3D is triggered
	
func _init():
	hasExploded = false
	free
	
func _process(delta):
	position += direction * speed * delta

func _destroy():
	emit_signal("destroyed")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if not hasExploded:
		emit_signal("outOfScreen")
		_destroy()

func _on_Projectile_area_entered(area):
	if area.has_method("die"):
		hasExploded = true
		area.die()
		_destroy()
