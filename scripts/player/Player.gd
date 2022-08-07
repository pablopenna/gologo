extends Node2D

export var speed = 150
export(PackedScene) var projectileScene

func _ready():
	pass
	
func _process(delta):
	_processPosition(delta)
	if Input.is_action_just_pressed("player_shoot"):
		shoot()
	
func _getMovementInput():
	var movement = 0
	if Input.is_action_pressed("player_left"):
		movement -= 1
	if Input.is_action_pressed("player_right"):
		movement += 1
	return movement

func _getMovement():
	return _getMovementInput() * speed
	
func _processPosition(delta):
	position.x += _getMovement() * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	
func shoot():
	print_debug("shoot!")
	var projectile = projectileScene.instance()
	projectile.direction = Vector2.UP
	projectile.position = position
	get_tree().root.add_child(projectile)

