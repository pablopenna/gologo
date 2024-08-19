class_name Projectile extends Area2D

@export var direction: Vector2 = Vector2.UP
@export var speed: int = 1
var hasExploded: bool

signal outOfScreen
signal destroyed # when destroying the projectile via queue_free(), VisibleOnScreenNotifier3D is triggered
	
func _init():
	hasExploded = false
	
func _process(delta):
	position += direction * speed * delta

func _destroy():
	destroyed.emit()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if not hasExploded:
		outOfScreen.emit()
		_destroy()

func _on_Projectile_area_entered(area):
	if area.has_method("die"):
		hasExploded = true
		area.die()
		_destroy()
