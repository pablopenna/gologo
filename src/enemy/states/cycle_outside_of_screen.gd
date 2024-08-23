extends State

@export var next_state: State
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
var viewport_size: Vector2
var enemy: Enemy

func _ready() -> void:
	state_name = "cycle_outside_of_screen"
	
func enter(_context: Dictionary) -> void:
	enemy = managed_node as Enemy
	viewport_size = get_viewport().size
	visible_on_screen_notifier.screen_exited.connect(_on_out_of_screen, CONNECT_ONE_SHOT)
	visible_on_screen_notifier.screen_entered.connect(_on_enter_of_screen, CONNECT_ONE_SHOT)
	
func physics_process(delta: float) -> void:
	enemy.global_position += Vector2.DOWN * enemy.speed * delta

func _on_out_of_screen() -> void:
	enemy.global_position += viewport_size.y * Vector2.UP
	
func _on_enter_of_screen() -> void:
	change_to_state.emit(next_state.state_name, {})
