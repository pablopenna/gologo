extends Node2D


export(PackedScene) var enemyScene
export var rows = 3
export var columns = 5
var spawnPoints = []

func _ready():
	_calculate_spawn_points()
	# update() # for debugging | triggers _draw() to be called again
	spawnEnemies()
	
func _calculate_spawn_points():
	var cellWidth = $SpawnArea.rect_size.x / columns
	var cellHeight = $SpawnArea.rect_size.y / rows
	var cellCenter = Vector2(cellWidth/2, cellHeight/2)
	
	for row in range(rows):
		for column in range(columns):
			var spawnPointCoordinates = Vector2(cellCenter.x + cellWidth*column, cellCenter.y + cellHeight*row)
			spawnPoints.append(spawnPointCoordinates)

func spawnEnemies():
	for point in spawnPoints:
		var enemy = enemyScene.instance()
		enemy.position = point
		add_child(enemy)
	
# Debug
func _draw():
	var topLeft = Vector2($SpawnArea.rect_position.x, $SpawnArea.rect_position.y)
	draw_circle(topLeft, 10, Color.red)
	var topRight = Vector2($SpawnArea.rect_position.x + $SpawnArea.rect_size.x, $SpawnArea.rect_position.y)
	draw_circle(topRight, 10, Color.red)
	var bottomLeft = Vector2($SpawnArea.rect_position.x, $SpawnArea.rect_position.y + $SpawnArea.rect_size.y)
	draw_circle(bottomLeft, 10, Color.red)
	var bottomRight = Vector2($SpawnArea.rect_position.x + $SpawnArea.rect_size.x, $SpawnArea.rect_position.y + $SpawnArea.rect_size.y)
	draw_circle(bottomRight, 10, Color.red)
	
	
	for point in spawnPoints:
		draw_circle(point, 5, Color.chartreuse)
	
