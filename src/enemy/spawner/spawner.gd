extends Node2D

@export var enemyScene: PackedScene
@export var rows: int = 3
@export var columns: int = 5
@export var show_position_debug: bool = false
@export var target: Node2D
@export var attack_target_timer: Timer
var spawn_area_size: Vector2

@export var spawn_point_move_speed: float = 5.0
@export var spawn_point_move_distance: int = 5
var spawn_move_angle: float = 0
var _enemies: Array[Enemy]
var _spawn_points: Array[Node2D]
var _original_spawn_coordinates: Array[Vector2]


func _ready():
	spawn_area_size = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y/3)
	var spawn_coordinates = _calculate_spawn_points()
	spawnEnemies(spawn_coordinates)
	
	attack_target_timer.timeout.connect(make_enemy_attack_target)

func _physics_process(delta: float) -> void:
	cycle_move_spawn_points(delta)
	
func _calculate_spawn_points() -> Array:
	var cellWidth = spawn_area_size.x / columns
	var cellHeight = spawn_area_size.y / rows
	var cellCenter = Vector2(cellWidth/2, cellHeight/2)
	var result = []
	
	for row in range(rows):
		for column in range(columns):
			var spawnPointCoordinates = Vector2(cellCenter.x + cellWidth*column, cellCenter.y + cellHeight*row)
			result.append(spawnPointCoordinates)
	return result

func spawnEnemies(spawn_points: Array):
	for point in spawn_points:
		var enemy_spawn_point = Node2D.new()
		enemy_spawn_point.global_position = point
		add_child(enemy_spawn_point)
		_spawn_points.append(enemy_spawn_point)
		_original_spawn_coordinates.append(Vector2(point))
		
		var enemy := enemyScene.instantiate() as Enemy
		enemy.global_position = point
		enemy.spawn_point = enemy_spawn_point
		enemy.target = target
		add_child(enemy)
		_enemies.append(enemy)
	
func cycle_move_spawn_points(delta: float) -> void:
	spawn_move_angle += delta * spawn_point_move_speed
	for i in range(_spawn_points.size()):
		var point = _spawn_points[i]
		var original_coordinates = _original_spawn_coordinates[i]
		point.global_position.x = original_coordinates.x + cos(spawn_move_angle) * spawn_point_move_distance
	
func make_enemy_attack_target() -> void:
	(get_child(6) as Enemy).go_to_target.emit()

func _draw():
	if not show_position_debug:
		return
	var topLeft = Vector2(0,0)
	draw_circle(topLeft, 10, Color.RED)
	var topRight = Vector2(spawn_area_size.x, 0)
	draw_circle(topRight, 10, Color.RED)
	var bottomLeft = Vector2(0, spawn_area_size.y)
	draw_circle(bottomLeft, 10, Color.RED)
	var bottomRight = Vector2(spawn_area_size.x, spawn_area_size.y*3)
	draw_circle(bottomRight, 10, Color.RED)
	#for point in spawnPoints:
		#draw_circle(point, 5, Color.CHARTREUSE)
