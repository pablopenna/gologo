extends Area2D

export var direction = Vector2.UP
export var speed = 100

const LayerAlias = preload("res://scripts/LayerAlias.gd")

signal outOfScreen
	
func _process(delta):
	position += direction * speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	emit_signal("outOfScreen")
