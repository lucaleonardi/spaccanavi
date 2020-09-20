extends Node2D

onready var spawn_points = $SpawnPoints
onready var spawn_timer = $SpawnTimer

export (bool) var active = true

const _hexagon = Preload.ENEMY.HEXAGON
const _tank = Preload.ENEMY.TANK
const _chaser = Preload.ENEMY.CHASER

const enemies = {
	0 : {
		actor = preload(_hexagon),
		probability = 0.5,
	},
	1 : {
		actor = preload(_tank),
		probability = 0.3,
	},
	2 : {
		actor = preload(_chaser),
		probability = 0.2,
	},
}

var random_point := 0
var random_enemy := 0

func _ready() -> void:
	randomize()
	
	if active:
		spawn_timer.start()

func _on_SpawnTimer_timeout() -> void:
	random_point = randi() % spawn_points.get_child_count()
	random_enemy = randi() % enemies.size()
	
	var enemy = enemies[random_enemy].actor.instance()
	enemy.global_position = spawn_points.get_child(random_point).global_position
	get_tree().root.get_node("World/Enemies").add_child(enemy)
