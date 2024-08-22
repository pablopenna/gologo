extends State

var managed_enemy: Enemy
@export var path_follow: PathFollow2D
var _path_created: bool = false

func _ready() -> void:
	state_name = "path_to_target"

func enter(_context: Dictionary) -> void:
	managed_enemy = managed_node as Enemy
	_create_path_to_target()

func physics_process(delta: float) -> void:
	if _path_created:
		path_follow.progress += managed_enemy.speed * delta
		managed_enemy.global_position = path_follow.global_position

func _create_path_to_target():
	var path = Path2D.new()
	var curve = Curve2D.new()
	path.curve = curve
	
	curve.add_point(managed_enemy.global_position)
	curve.add_point(managed_enemy.target.global_position)
	
	add_child(path)
	path_follow.reparent(path)
	_path_created = true
