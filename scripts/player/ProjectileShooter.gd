extends Node2D

@export var projectileScene: PackedScene

@export var shootingCooldown = 0.05
@export var projectileSpeed = 750
@export var maxProjectiles = 3
var currentProjectiles

func _ready():
	currentProjectiles = 0
	$ShootingTimer.start(shootingCooldown)
	
func shoot():
	if $ShootingTimer.time_left == 0 && currentProjectiles < maxProjectiles:
		_createAndLaunchProjectile()
	
func _createAndLaunchProjectile():
	$ShootingTimer.start(shootingCooldown)
	currentProjectiles += 1
	
	var projectile:  = projectileScene.instantiate()
	# https://docs.godotengine.org/en/4.2/tutorials/physics/physics_introduction.html#collision-layers-and-masks
	projectile.set_collision_layer_value(Aliases.LayerAlias.PLAYER_PROJECTILE, true)
	projectile.set_collision_mask_value(Aliases.LayerAlias.ENEMY, true)
	projectile.direction = Vector2.UP
	projectile.speed = projectileSpeed
	# IMPORTANT - position returns the coordinates relative to parent
	# if you are gonna instantiate the child under the root of the tree, 
	# you need to use global_position instead of position
	projectile.position = global_position 
	projectile.connect("destroyed", Callable(self, "_projectileDestroyed"))
	get_tree().get_root().add_child(projectile)

func _projectileDestroyed():
	currentProjectiles -= 1
