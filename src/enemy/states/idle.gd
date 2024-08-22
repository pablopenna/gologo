extends State

@export var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	state_name = "idle"

func enter(_context: Dictionary) -> void:
	animated_sprite.play("idle")
