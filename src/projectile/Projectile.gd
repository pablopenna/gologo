class_name Projectile extends Area2D

@export var fix_collision_shape: CollisionShape2D
var position_in_past_frame: Vector2

@export var direction: Vector2 = Vector2.UP
@export var speed: int = 1
var _hasExploded: bool = false

signal outOfScreen
signal destroyed # when destroying the projectile via queue_free(), VisibleOnScreenNotifier3D is triggered

func _ready() -> void:
	position_in_past_frame = position
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	_update_fix_collision_shape()

func _update_fix_collision_shape() -> void:
	var shape = fix_collision_shape.shape as RectangleShape2D
	var distance_to_last_position = abs(position.distance_to(position_in_past_frame))
	shape.size.y = distance_to_last_position
	fix_collision_shape.position.y -= (direction.y * distance_to_last_position)/2
	
	position_in_past_frame = position

func _destroy():
	destroyed.emit()
	call_deferred("queue_free")

func _on_VisibilityNotifier2D_screen_exited():
	if not _hasExploded:
		await get_tree().create_timer(2).timeout
		outOfScreen.emit()
		_destroy()

func _on_Projectile_area_entered(area):
	var hit_entity := area as DamageableEntity
	if hit_entity != null and _hasExploded == false:
		hit_entity.damaged.emit()
		_hasExploded = true
		_destroy()
