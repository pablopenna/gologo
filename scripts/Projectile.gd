extends Area2D

export var direction = Vector2.UP
export var speed = 100

const LayerAlias = preload("res://scripts/LayerAlias.gd")

signal outOfScreen
signal destroyed
	
func _process(delta):
	position += direction * speed * delta

func destroy():
	emit_signal("destroyed")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("outOfScreen")
	destroy()

func _on_Projectile_area_entered(area):
	if area.has_method("die"):
		area.die()
		destroy()
