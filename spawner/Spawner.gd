tool
extends Area2D

onready var spawn_area: CollisionShape2D = $SpawnArea
onready var top_left: Position2D = $TopLeft
onready var bottom_right: Position2D = $BottomRight

export (int) var spawn_point_number = 4

const EnemyType = preload("res://enemies/hexagon/Hexagon.tscn")

var spawn_position := Vector2.ZERO
var spawn_size := Vector2.ZERO

func _ready() -> void:
	var h_top_pos = top_left.global_position.x
	var h_steps: float = -h_top_pos * 2 / spawn_point_number
	for i in range(spawn_point_number):
		var spawn_point = Position2D.new()
		spawn_point.global_position = Vector2(top_left.global_position.x + h_steps * i, top_left.global_position.y)
		add_child(spawn_point)

func _on_SpawnTimer_timeout() -> void:
	spawn_position.x = (randi() % int(spawn_size.x))
	spawn_position.y = (randi() % int(spawn_size.y))
	
	var enemy = EnemyType.instance()
	enemy.position = spawn_position
	add_child(enemy)
