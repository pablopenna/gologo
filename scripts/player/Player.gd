extends Node2D

export var speed = 150
export(PackedScene) var projectileScene

export var shootingCooldown = 0.05
export var projectileSpeed = 750
export var maxProjectiles = 3
var currentProjectiles

const LayerAlias = preload("res://scripts/LayerAlias.gd")

var dead
signal playerDied

func _ready():
	currentProjectiles = 0
	dead = false
	$ShootingTimer.start(shootingCooldown)
	
func _process(delta):
	if not dead:
		_processPosition(delta)
		if Input.is_action_just_pressed("player_shoot") && $ShootingTimer.time_left == 0 && currentProjectiles < maxProjectiles:
			shoot()
	
func _processPosition(delta):
	var movement = _getMovementInput()
	position.x += movement * speed * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)	
	
	
	if movement != 0:
		$AnimatedSprite.play("move")
		if movement < 0:
			$AnimatedSprite.flip_h = true  
		else: 
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("idle")

func _getMovementInput():
	var movement = 0
	if Input.is_action_pressed("player_left"):
		movement -= 1
	if Input.is_action_pressed("player_right"):
		movement += 1
	return movement
	
func shoot():
	$ShootingTimer.start(shootingCooldown)
	currentProjectiles+=1
	
	var projectile = projectileScene.instance()
	# Overall, if the objects are A and B, 
	# the check for collision is 
	# A.mask & B.layers || B.mask & A.layers, 
	# where & is bitwise-and, and || is the or operator. 
	# I.e. it takes the layers that correspond to the other object's mask, and checks if any of them is on in both places. It will they proceed to check it the other way around, and if any of the two tests passes, it would report the collision.
	projectile.set_collision_layer_bit(LayerAlias.LayerAlias.PLAYER_PROJECTILE, true)
	projectile.set_collision_mask_bit(LayerAlias.LayerAlias.ENEMY, true)
	projectile.direction = Vector2.UP
	projectile.speed = projectileSpeed
	projectile.position = position
	projectile.connect("destroyed", self, "_projectileDestroyed")
	
	get_tree().root.add_child(projectile)

func _projectileDestroyed():
	currentProjectiles-=1
	
func die():
	dead = true
	$AnimatedSprite.play("explode")
	emit_signal("playerDied")
	yield($AnimatedSprite, "animation_finished")
	queue_free()
