extends Node2D
class_name Spawner

onready var spawn_points = $SpawnPoints
onready var spawn_timer = $SpawnTimer

export (bool) var active = true
export (float) var spawn_speed = 1.0

func _ready() -> void:
	randomize()	
	if active:
		spawn_timer.start(spawn_speed)

func random_element(element_list: Dictionary) -> int:
	return randi() % int(clamp(WaveManager.current_wave + 2, 0, element_list.size()))

func random_point() -> int:
	return randi() % spawn_points.get_child_count()

func _on_SpawnTimer_timeout() -> void:
	pass
