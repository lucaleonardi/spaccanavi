extends Enemy

export (float) var speed = 50

onready var player = get_tree().root.get_node("World/Player/Default")

func _physics_process(delta):
	if get_tree().root.get_node("World/Player").has_node("Default"):
		global_position += (player.global_position - global_position) / speed
		look_at(player.global_position)

func _on_Stats_no_health() -> void:
	queue_free()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.connect("effect_finished", death_effect, "queue_free")
	death_effect.global_position = global_position
	death_effect.emitting = true
	death_effect.set_modulate(modulate)
	death_effect.transform.scaled(Vector2(0.5, 0.5))
	
	death_effect.set_as_toplevel(true)
	get_parent().add_child(death_effect)


func _on_Chaser_body_entered(body: Node) -> void:
	if body is Bullet:
		stats.health -= body.damage
	
	if body is Player:
		stats.health = 0
