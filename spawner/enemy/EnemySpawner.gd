extends Spawner

const _hexagon = Preload.ENEMY.HEXAGON
const _tank = Preload.ENEMY.TANK
const _chaser = Preload.ENEMY.CHASER
const _triangle = Preload.ENEMY.TRIANGLE
const _little_star = Preload.ENEMY.LITTLESTAR
const _sniper = Preload.ENEMY.SNIPER

const enemies = {
	0: preload(_hexagon),
	1: preload(_tank),
	2: preload(_chaser),
	3: preload(_triangle),
	4: preload(_little_star),
	5: preload(_sniper),
}

func _on_SpawnTimer_timeout() -> void:
	if active:
		var enemy = enemies[random_element(enemies)].instance()
		enemy.global_position = spawn_points.get_child(random_point()).global_position
		get_tree().root.get_node("World/Enemies").add_child(enemy)
