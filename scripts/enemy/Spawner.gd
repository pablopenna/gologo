extends Node2D


@export var enemyScene: PackedScene
@export var rows = 3
@export var columns = 5
var spawnPoints = []

func _ready():
	_calculate_spawn_points()
	# update() # for debugging | triggers _draw() to be called again
	spawnEnemies()
	
func _calculate_spawn_points():
	var cellWidth = $SpawnArea.size.x / columns
	var cellHeight = $SpawnArea.size.y / rows
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
	var topLeft = Vector2($SpawnArea.position.x, $SpawnArea.position.y)
	draw_circle(topLeft, 10, Color.RED)
	var topRight = Vector2($SpawnArea.position.x + $SpawnArea.size.x, $SpawnArea.position.y)
	draw_circle(topRight, 10, Color.RED)
	var bottomLeft = Vector2($SpawnArea.position.x, $SpawnArea.position.y + $SpawnArea.size.y)
	draw_circle(bottomLeft, 10, Color.RED)
	var bottomRight = Vector2($SpawnArea.position.x + $SpawnArea.size.x, $SpawnArea.position.y + $SpawnArea.size.y)
	draw_circle(bottomRight, 10, Color.RED)
	
	
	for point in spawnPoints:
		draw_circle(point, 5, Color.CHARTREUSE)
	
