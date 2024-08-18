class_name ProjectileShooter extends Node2D

@export var projectileScene: PackedScene
@export var faction: Faction
@export var audio_player: RandomPitchAudioStreamPlayer

@export var shootingCooldown = 0.05
@export var projectileSpeed = 750
@export var maxProjectiles = 3
var currentProjectiles

signal projectile_shot

func _ready():
	currentProjectiles = 0
	$ShootingTimer.start(shootingCooldown)
	projectile_shot.connect(func(): audio_player.play_with_random_pitch())
	
func shoot():
	if $ShootingTimer.time_left == 0 && currentProjectiles < maxProjectiles:
		_createAndLaunchProjectile()
	
func _createAndLaunchProjectile():
	$ShootingTimer.start(shootingCooldown)
	currentProjectiles += 1
	
	var projectile := projectileScene.instantiate() as Projectile
	# https://docs.godotengine.org/en/4.2/tutorials/physics/physics_introduction.html#collision-layers-and-masks
	projectile.collision_layer = GetFactionParam.get_collision_layer_for_projectile(faction.faction)
	projectile.collision_mask = GetFactionParam.get_collision_mask_for(faction.faction)
	projectile.direction = GetFactionParam.get_projectile_direction_for(faction.faction)
	projectile.speed = projectileSpeed
	# IMPORTANT - position returns the coordinates relative to parent
	# if you are gonna instantiate the child under the root of the tree, 
	# you need to use global_position instead of position
	projectile.position = global_position 
	projectile.connect("destroyed", Callable(self, "_projectileDestroyed"))
	get_parent().get_parent().add_child(projectile)
	projectile_shot.emit()

func _projectileDestroyed():
	currentProjectiles -= 1
