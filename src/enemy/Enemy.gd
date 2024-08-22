class_name Enemy extends DamageableEntity

@export var projectile_shooter: ProjectileShooter
@export var speed = 10
@export var rotationSpeed = 5
@export var target: Node2D

signal go_to_target
