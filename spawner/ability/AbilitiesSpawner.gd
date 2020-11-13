extends Spawner

const _pickup = Preload.PICKUP

const _shield = Preload.ABILITY.SHIELD
const _shield_sprite = Preload.SPRITE.ABILITY.SHIELD
const _slow_motion = Preload.ABILITY.SLOW_MOTION
const _slow_motion_sprite = Preload.SPRITE.ABILITY.SLOW_MOTION
const _LASERONE = Preload.ABILITY.LASERONE
const _LASERONE_sprite = Preload.SPRITE.ABILITY.LASERONE

onready var PickupScene = preload(_pickup)

const abilities = {
	0 : {
		item = preload(_shield),
		sprite = preload(_shield_sprite),
		probability = 0.5,
	},
	1 : {
		item = preload(_slow_motion),
		sprite = preload(_slow_motion_sprite),
		probability = 0.5,
	},
	2 : {
		item = preload(_LASERONE),
		sprite = preload(_LASERONE_sprite),
		probability = 0.5,
	},
}

func _on_SpawnTimer_timeout() -> void:
	if active:
		var random_element = random_element(abilities)
		var random_point = random_point()
		var pickup = PickupScene.instance()
			
		pickup.PickupItem = abilities[random_element].item
		pickup.texture = abilities[random_element].sprite
		pickup.global_position = spawn_points.get_child(random_point).global_position	
		get_tree().root.get_node("World/Pickups").add_child(pickup)
	
