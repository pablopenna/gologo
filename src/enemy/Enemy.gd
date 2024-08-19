extends Area2D

@export var projectile_shooter: ProjectileShooter

@export var speed = 10
@export var rotationSpeed = 5

func _ready():
	$AnimatedSprite2D.play("idle")

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
	
	if Input.is_action_pressed("ui_focus_next"):
		projectile_shooter.shoot()

func die():
	# prevent player projectiles for interacting with it while exploding
	collision_layer = 0
	collision_mask = 0
	
	$AnimatedSprite2D.play("explode")
	await $AnimatedSprite2D.animation_finished
	queue_free()
