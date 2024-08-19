class_name Player extends Node2D

@export var speed = 150
var dead: bool
const MARGIN: int = 4

signal playerDied

func _ready():
	dead = false
	
func _process(delta):
	if not dead:
		_processPosition(delta)
		if Input.is_action_just_pressed("player_shoot"):
			$ProjectileShooter.shoot()
	
func _processPosition(delta):
	var movement = _getMovementInput()
	position.x += movement * speed * delta
	position.x = clamp(position.x, 0 + MARGIN, get_viewport_rect().size.x - MARGIN)	
	
	if movement != 0:
		$AnimatedSprite2D.play("move")
		if movement > 0:
			$AnimatedSprite2D.flip_h = true  
		else: 
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

func _getMovementInput():
	var movement = 0
	if Input.is_action_pressed("player_left"):
		movement -= 1
	if Input.is_action_pressed("player_right"):
		movement += 1
	return movement

func die():
	dead = true
	$AnimatedSprite2D.play("explode")
	emit_signal("playerDied")
	await $AnimatedSprite2D.animation_finished
	queue_free()
