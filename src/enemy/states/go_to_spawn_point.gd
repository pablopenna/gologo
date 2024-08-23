extends State

var actor: Enemy
@export var margin_to_target: float = 2.0

func _ready() -> void:
	state_name = "go_to_spawn_point"

func enter(_context: Dictionary) -> void:
	actor = managed_node as Enemy

func physics_process(delta: float) -> void:
	var target_position: Vector2 = actor.spawn_point.global_position
	if actor.global_position.distance_to(target_position) > margin_to_target:
		var direction_to_spawn_point: Vector2 = actor.global_position.direction_to(target_position).normalized()
		actor.global_position += direction_to_spawn_point * actor.speed * delta
