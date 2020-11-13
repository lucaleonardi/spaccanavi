extends Spawner

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

func _on_SpawnTimer_timeout() -> void:
	if active:
		var enemy = enemies[random_element(enemies)].actor.instance()
		enemy.global_position = spawn_points.get_child(random_point()).global_position
		get_tree().root.get_node("World/Enemies").add_child(enemy)
