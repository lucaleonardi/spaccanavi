extends Spawner

const _pickup = Preload.PICKUP

const _shield = Preload.ABILITY.SHIELD
const _shield_sprite = Preload.SPRITE.ABILITY.SHIELD
const _slow_motion = Preload.ABILITY.SLOW_MOTION
const _slow_motion_sprite = Preload.SPRITE.ABILITY.SLOW_MOTION
const _LASERONE = Preload.ABILITY.LASERONE
const _LASERONE_sprite = Preload.SPRITE.ABILITY.LASERONE
const _you_are_the_bullet = Preload.ABILITY.YOU_ARE_THE_BULLET
const _you_are_the_bullet_sprite = Preload.SPRITE.ABILITY.YOU_ARE_THE_BULLET
const _multi_gun = Preload.ABILITY.MULTI_GUN
const _multi_gun_sprite = Preload.SPRITE.ABILITY.MULTI_GUN
const _medkit = Preload.ABILITY.MEDKIT
const _medkit_sprite = Preload.SPRITE.ABILITY.MEDKIT

onready var PickupScene = preload(_pickup)

const abilities = {
	0 : {
		item = preload(_shield),
		sprite = preload(_shield_sprite),
	},
	1 : {
		item = preload(_slow_motion),
		sprite = preload(_slow_motion_sprite),
	},
	2 : {
		item = preload(_LASERONE),
		sprite = preload(_LASERONE_sprite),
	},
	3 : {
		item = preload(_you_are_the_bullet),
		sprite = preload(_you_are_the_bullet_sprite),
	},
	4 : {
		item = preload(_multi_gun),
		sprite = preload(_multi_gun_sprite),
	},
	5 : {
		item = preload(_medkit),
		sprite = preload(_medkit_sprite),
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
	
