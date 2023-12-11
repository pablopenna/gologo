extends Area2D

@export var projectileScene: PackedScene
@export var projectileSpeed = 500

@export var speed = 300
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
		shoot()
		
func shoot():
	var projectile: Area2D = projectileScene.instantiate()
	projectile.set_collision_layer_value(Aliases.LayerAlias.ENEMY_PROJECTILE, true)
	projectile.set_collision_mask_value(Aliases.LayerAlias.PLAYER, true)
	projectile.direction = Vector2.DOWN
	projectile.speed = projectileSpeed
	projectile.position = position
	get_tree().root.add_child(projectile)

func die():
	# prevent player projectiles for interacting with it while exploding
	set_collision_layer_value(Aliases.LayerAlias.ENEMY, false)
	set_collision_mask_value(Aliases.LayerAlias.PLAYER_PROJECTILE, false)
	
	$AnimatedSprite2D.play("explode")
	await $AnimatedSprite2D.animation_finished
	queue_free()
