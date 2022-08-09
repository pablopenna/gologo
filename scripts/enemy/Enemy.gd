extends Area2D

export var speed = 300
export var rotationSpeed = 5

const LayerAlias = preload("res://scripts/LayerAlias.gd")

func _ready():
	$AnimatedSprite.play("idle")

func _process(delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		rotation -= rotationSpeed * delta
	if Input.is_action_pressed("ui_right"):
		rotation += rotationSpeed * delta
	if Input.is_action_pressed("ui_up"):
		movement = Vector2(speed,0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		movement = Vector2(-speed,0).rotated(rotation)
	position += movement * delta


func _on_Enemy_area_entered(area):
	if(area.get_collision_layer_bit(LayerAlias.LayerAlias.PLAYER_PROJECTILE)):
		$AnimatedSprite.play("explode")
		yield($AnimatedSprite, "animation_finished")
		queue_free()
