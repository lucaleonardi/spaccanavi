extends RigidBody2D
class_name Enemy

const effect_path: String = Preload.EFFECT.DEATH

const DeathEffect := preload(effect_path)

onready var stats: Node = $Stats

func _on_Enemy_body_entered(body: Node) -> void:
	if body is Bullet:
		stats.health -= body.damage

func _on_Stats_no_health() -> void:
	print("death")
	queue_free()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.connect("effect_finished", death_effect, "queue_free")
	death_effect.emitting = true
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position
