extends Spawner

const _hexagon = Preload.ENEMY.HEXAGON
const _tank = Preload.ENEMY.TANK
const _chaser_group = Preload.ENEMY.CHASER_GROUP
const _triangle = Preload.ENEMY.TRIANGLE
const _aggressive_chaser = Preload.ENEMY.AGGRESSIVE_CHASER
const _little_star = Preload.ENEMY.LITTLESTAR
const _sniper = Preload.ENEMY.SNIPER

const enemies = {
	0: preload(_chaser_group),
	1: preload(_hexagon),
	2: preload(_tank),
	3: preload(_triangle),
	4: preload(_aggressive_chaser),
	5: preload(_little_star),
	6: preload(_sniper),
}

func _on_SpawnTimer_timeout() -> void:
	if active:
		var enemy = enemies[random_element(enemies)].instance()
		enemy.global_position = spawn_points.get_child(random_point()).global_position
		get_tree().root.get_node("World/Enemies").add_child(enemy)

func random_element(element_list: Dictionary) -> int:
	return int(
		fposmod(
			randi() % int(
				element_list.size()), 
				WaveManager.current_wave + 2
				)
		)
