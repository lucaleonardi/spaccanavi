extends Node2D

onready var spawn_points = $SpawnPoints

export var EnemyType = preload("res://enemies/tank/Tank.tscn")

var random_point := 0

func _on_SpawnTimer_timeout() -> void:
	random_point = randi() % spawn_points.get_child_count()
	
	var enemy = EnemyType.instance()
	enemy.global_position = spawn_points.get_child(random_point).global_position
	get_tree().root.get_node("World/Enemies").add_child(enemy)
