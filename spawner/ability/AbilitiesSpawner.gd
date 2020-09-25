extends Spawner

const _pickup = Preload.PICKUP
const _shield = Preload.ABILITY.SHIELD
const _shield_sprite = Preload.SPRITE.ABILITY.SHIELD

onready var PickupScene = preload(_pickup)

const abilities = {
	0 : {
		item = preload(_shield),
		sprite = preload(_shield_sprite),
		probability = 0.5,
	},
}

func _on_SpawnTimer_timeout() -> void:
	var random_element = random_element(abilities)
	var random_point = random_point()
	var pickup = PickupScene.instance()
		
	pickup.PickupItem = abilities[random_element].item
	pickup.texture = abilities[random_element].sprite
	pickup.global_position = spawn_points.get_child(random_point).global_position	
	get_tree().root.get_node("World/Pickups").add_child(pickup)
	
