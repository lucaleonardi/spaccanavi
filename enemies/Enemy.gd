extends RigidBody2D
class_name Enemy

signal enemy_death

export (float) var speed = 0.0
export (int) var wave_points = 0

const effect_path: String = Preload.EFFECT.DEATH
const DeathEffect := preload(effect_path)

onready var player = get_tree().root.get_node("World/Player/Default")
onready var stats: Node = $Stats
onready var enabler: VisibilityEnabler2D = $VisibilityEnabler2D

var direction := Vector2.ZERO
var distance_to_player := 0.0
var _is_hit_by_player = false


func _ready() -> void:
	connect("enemy_death", WaveManager, "increment_wave_bar")

func chase_player() -> void:
	direction = (player.global_position - global_position).normalized()
	distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player > 10.0:
		apply_central_impulse(direction * speed)

func _on_Enemy_body_entered(body: Node) -> void:
	if body is Bullet:
		if body.is_in_group("enemy"):
			_is_hit_by_player = false
		elif body.is_in_group("player"):
			_is_hit_by_player = true
				
		stats.health -= body.damage

func _on_Stats_no_health() -> void: 
	if _is_hit_by_player:
		emit_signal("enemy_death", wave_points)
	queue_free()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.global_position = global_position
	death_effect.emitting = true
	death_effect.set_modulate(modulate)
	
	death_effect.set_as_toplevel(true)
	get_parent().add_child(death_effect)
