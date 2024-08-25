class_name Projectile extends Area2D

@export var fix_collision_raycast: RayCast2D

@export var direction: Vector2 = Vector2.UP
@export var speed: int = 1
var _hasExploded: bool = false
var _is_out_of_screen: bool = false

signal outOfScreen
signal destroyed # when destroying the projectile via queue_free(), VisibleOnScreenNotifier3D is triggered

func _ready() -> void:
	fix_collision_raycast.collision_mask = self.collision_mask
	area_entered.connect(_on_Projectile_area_entered)
	
func _physics_process(delta: float) -> void:
	var original_position = Vector2(global_position)
	global_position += direction * speed * delta
	_update_fix_collision_raycast(original_position)
	if fix_collision_raycast.is_colliding():
		_on_Projectile_area_entered(fix_collision_raycast.get_collider())
	if _is_out_of_screen:
		_destroy()

func _update_fix_collision_raycast(raycast_position: Vector2) -> void:
	fix_collision_raycast.global_position = raycast_position
	fix_collision_raycast.target_position = raycast_position.direction_to(global_position) * raycast_position.distance_to(global_position)

func _destroy():
	destroyed.emit()
	call_deferred("queue_free")

func _on_VisibilityNotifier2D_screen_exited():
	_is_out_of_screen = true

func _on_Projectile_area_entered(area):
	var hit_entity := area as DamageableEntity
	if hit_entity != null and _hasExploded == false:
		hit_entity.damaged.emit()
		_hasExploded = true
		_destroy()
