extends Position2D

const bullet_path: String = Preload.BULLET.PLASMA
const effect_path: String = Preload.EFFECT.HIT

export (int) var bullet_velocity = 500
export (PackedScene) var BulletType = preload(bullet_path)
export (PackedScene) var HitEffect = preload(effect_path)

onready var timer = $Cooldown

func shoot(enemy_color: Color, spaceship_rotation: float, spaceship_velocity: Vector2) -> void:
	var bullet: RigidBody2D = BulletType.instance()
	var direction := Vector2(
			cos(spaceship_rotation), 
			sin(spaceship_rotation)
			)
	
	bullet.connect("hit", self, "create_hit_effect", [direction])
	bullet.global_position = global_position
	bullet.rotation = spaceship_rotation
	bullet.apply_central_impulse(direction * bullet_velocity + spaceship_velocity)
	bullet.set_modulate(enemy_color)
	
#	bullet.set_as_toplevel(true)
	get_tree().root.get_node("World/Bullets").add_child(bullet)

func create_hit_effect(enemy_color: Color, hit_global_position: Vector2, hit_direction: Vector2) -> void:
	var hit: CPUParticles2D = HitEffect.instance()
	hit.connect("effect_finished", hit, "queue_free")
	hit.global_position = hit_global_position
	hit.set_direction(-hit_direction)
	hit.set_emitting(true)
	hit.set_modulate(enemy_color)
	
	hit.set_as_toplevel(true)
	add_child(hit)
