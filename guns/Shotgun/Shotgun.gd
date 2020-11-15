extends Gun

func shoot(enemy_color: Color, spaceship_rotation: float, spaceship_velocity: Vector2) -> void:
	var bullet: RigidBody2D = BulletType.instance()
	bullet.add_to_group(bullet_group)
	var direction := Vector2(
			cos(spaceship_rotation), 
			sin(spaceship_rotation)
			)
	
	bullet.connect("hit", self, "create_hit_effect", [direction])
	bullet.global_position = global_position
	bullet.rotation = spaceship_rotation
	bullet.apply_central_impulse(direction * bullet_velocity * 1/sqrt(Engine.time_scale) + spaceship_velocity)
	bullet.set_modulate(enemy_color)
	
	get_tree().root.get_node("World/Bullets").add_child(bullet)
