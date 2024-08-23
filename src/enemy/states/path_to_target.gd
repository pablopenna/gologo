extends State

var managed_enemy: Enemy
var _path_follow: PathFollow2D
var _path_created: bool = false

@export var on_reached_destination_state: State
signal reached_destination

func _ready() -> void:
	state_name = "path_to_target"
	_setup_path_follow()
	reached_destination.connect(_on_reached_destination)

func enter(_context: Dictionary) -> void:
	managed_enemy = managed_node as Enemy
	_create_path_to_target()

func physics_process(delta: float) -> void:
	if _path_created:
		_path_follow.progress += managed_enemy.speed * delta
		managed_enemy.global_position = _path_follow.global_position
		if _path_follow.progress_ratio == 1:
			reached_destination.emit()

func _setup_path_follow() -> void:
	_path_follow = PathFollow2D.new()
	_path_follow.loop = false
	add_child(_path_follow)

func _create_path_to_target() -> void:
	var path = Path2D.new()
	var curve = Curve2D.new()
	path.curve = curve
	
	curve.add_point(managed_enemy.global_position)
	curve.add_point(managed_enemy.target.global_position)
	
	add_child(path)
	_path_follow.reparent(path)
	_path_created = true

func _on_reached_destination() -> void:
	change_to_state.emit(on_reached_destination_state.state_name, {})
	
	
