extends State

@export var animated_sprite: AnimatedSprite2D
var managed_enemy: Enemy

func _ready() -> void:
	state_name = "die"

func enter(_context: Dictionary) -> void:
	managed_enemy = managed_node as Enemy
	# prevent player projectiles for interacting with it while exploding
	managed_enemy.collision_layer = 0
	managed_enemy.collision_mask = 0
	
	animated_sprite.play("explode")
	await animated_sprite.animation_finished
	managed_enemy.call_deferred("queue_free")
