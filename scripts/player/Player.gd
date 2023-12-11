extends Node2D

@export var speed = 150

var dead
signal playerDied

func _ready():
	dead = false
	$PlayerStateMachine.statesMap = {
		"idle": $PlayerStateMachine/PlayerIdleState,
		"move": $PlayerStateMachine/PlayerMoveState
	}
	
	$PlayerStateMachine.initialize("idle")
	
func _process(delta):
	$PlayerStateMachine.currentState.process()
	
	if not dead:
		_processPosition(delta)
		if Input.is_action_just_pressed("player_shoot"):
			$ProjectileShooter.shoot()
	
func _processPosition(delta):
	var movement = _getMovementInput()
	position.x += movement * speed * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)	
	
	
	if movement != 0:
		$AnimatedSprite2D.play("move")
		if movement < 0:
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
	
### TODO: move this functionality to Hurtbox node
func die():
	dead = true
	$AnimatedSprite2D.play("explode")
	emit_signal("playerDied")
	await $AnimatedSprite2D.animation_finished
	queue_free()
