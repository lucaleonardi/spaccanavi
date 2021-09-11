extends Node2D

const _chaser = Preload.ENEMY.CHASER
const Chaser = preload(_chaser)

export(int) var min_size = 3
export(int) var max_size = 5

func _ready() -> void:
	var _group_size = randi() % (max_size - min_size) + min_size
	for member in _group_size:
		var chaser = Chaser.instance()
		var _spawn_offset = Vector2(rand_range(-10.0, 10.0), rand_range(-10.0, 10.0))
		chaser.global_position = global_position + _spawn_offset
		get_parent().add_child(chaser)
	queue_free()
