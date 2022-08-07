extends Node2D

export var speed = 150
export(PackedScene) var projectileScene

export var shootingCooldown = 0.05
export var projectileSpeed = 750
export var maxProjectiles = 3
var currentProjectiles

func _ready():
	currentProjectiles = 0
	$ShootingTimer.start(shootingCooldown)
	
func _process(delta):
	_processPosition(delta)
	if Input.is_action_just_pressed("player_shoot") && $ShootingTimer.time_left == 0 && currentProjectiles < maxProjectiles:
		shoot()
	
func _processPosition(delta):
	position.x += _getMovementInput() * speed * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)	

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
	projectile.direction = Vector2.UP
	projectile.speed = projectileSpeed
	projectile.position = position
	projectile.connect("outOfScreen", self, "_projectileDestroyed")
	
	get_tree().root.add_child(projectile)

func _projectileDestroyed():
	currentProjectiles-=1
	
