extends Node2D

export(PackedScene) var projectileScene

export var shootingCooldown = 0.05
export var projectileSpeed = 750
export var maxProjectiles = 3
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
	
	var projectile = projectileScene.instance()
	# Overall, if the objects are A and B, 
	# the check for collision is 
	# A.mask & B.layers || B.mask & A.layers, 
	# where & is bitwise-and, and || is the or operator. 
	# I.e. it takes the layers that correspond to the other object's mask, and checks if any of them is on in both places. It will they proceed to check it the other way around, and if any of the two tests passes, it would report the collision.
	projectile.set_collision_layer_bit(Aliases.LayerAlias.PLAYER_PROJECTILE, true)
	projectile.set_collision_mask_bit(Aliases.LayerAlias.ENEMY, true)
	projectile.direction = Vector2.UP
	projectile.speed = projectileSpeed
	# IMPORTANT - position returns the coordinates relative to parent
	# if you are gonna instantiate the child under the root of the tree, 
	# you need to use global_position instead of position
	projectile.position = global_position 
	projectile.connect("destroyed", self, "_projectileDestroyed")
	get_tree().get_root().add_child(projectile)

func _projectileDestroyed():
	currentProjectiles -= 1
