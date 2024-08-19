extends Node2D

@export var enemyScene: PackedScene
@export var rows: int = 3
@export var columns: int = 5
var spawnPoints: Array
var spawn_area_size: Vector2

@export var show_position_debug: bool = false

func _ready():
	spawnPoints = []
	spawn_area_size = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y/3)
	_calculate_spawn_points()
	# update() # for debugging | triggers _draw() to be called again
	spawnEnemies()
	
func _calculate_spawn_points():
	var cellWidth = spawn_area_size.x / columns
	var cellHeight = spawn_area_size.y / rows
	var cellCenter = Vector2(cellWidth/2, cellHeight/2)
	
	for row in range(rows):
		for column in range(columns):
			var spawnPointCoordinates = Vector2(cellCenter.x + cellWidth*column, cellCenter.y + cellHeight*row)
			spawnPoints.append(spawnPointCoordinates)

func spawnEnemies():
	for point in spawnPoints:
		var enemy = enemyScene.instantiate()
		enemy.position = point
		add_child(enemy)
	
# Debug
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
	
	
	for point in spawnPoints:
		draw_circle(point, 5, Color.CHARTREUSE)
	
