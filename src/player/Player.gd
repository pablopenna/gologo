class_name Player extends Node2D

@export var speed = 150
var dead: bool
const MARGIN: int = 4

signal playerDied

func _ready():
	dead = false
	position.x = get_viewport_rect().size.x/2
	
func _process(delta):
	if not dead:
		_processPosition(delta)
		if Input.is_action_just_pressed("player_shoot"):
			$ProjectileShooter.shoot()
	
func _processPosition(delta):
	var movement: Vector2 = _getMovementInput()
	position += movement * speed * delta
	position.x = clamp(position.x, 0 + MARGIN, get_viewport_rect().size.x - MARGIN)	
	
	if movement.x != 0:
		$AnimatedSprite2D.play("move")
		if movement.x > 0:
			$AnimatedSprite2D.flip_h = true  
		else: 
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

func _getMovementInput():
	var movement = Vector2.ZERO
	movement.x = Input.get_axis("player_left","player_right")
	movement.y = Input.get_axis("player_up","player_down")
	return movement

func die():
	dead = true
	$AnimatedSprite2D.play("explode")
	emit_signal("playerDied")
	await $AnimatedSprite2D.animation_finished
	queue_free()
