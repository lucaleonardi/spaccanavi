extends Ability

#const effect_path: String = Preload.EFFECT.DEATH
#const DeathEffect := preload(effect_path)

var boost := Vector2.ZERO
var damage := 1000

onready var timer: Timer = $Timer
onready var sprite: Sprite = $Sprite
onready var almostFinishedPlayer: AnimationPlayer = $AlmostFinishedAnimation
onready var player = get_parent()

func _ready() -> void:
	player.invincible = true
	player.linear_damp = 4
	player.max_actual_speed = player.max_speed * 1.5
	player.shooting_cooldown.start()
	player.shooting_cooldown.paused = true
	
	almostFinishedPlayer.play("Stop")
	timer.connect("timeout", self, "finishing_ability")
	activate()

func activate() -> void:
	timer.start(duration)

func finishing_ability() -> void:
	almostFinishedPlayer.play("Start")

func _physics_process(delta: float) -> void:	
	boost = Vector2(
			cos(player.raycast.rotation), 
			sin(player.raycast.rotation)
			) * player.engine_thrust * 8
	
	sprite.rotation = player.raycast.rotation
	player.set_applied_force(player.applied_force + boost)

func _on_body_entered(body: Node) -> void:	
	if body is Enemy:
		body._is_hit_by_player = true
		body.stats.health -= damage

func disable() -> void:
	set_physics_process(false)
	
	player.invincible = false
	player.linear_damp = 0.5
	player.max_actual_speed = player.max_speed
	player.shooting_cooldown.paused = false
	player.shooting_cooldown.stop()
	
#	var death_effect: CPUParticles2D = DeathEffect.instance()
#	death_effect.connect("effect_finished", death_effect, "queue_free")
#	death_effect.scale_amount *= 2
#	death_effect.emitting = true
#	player.add_child(death_effect)
	
	emit_signal("ability_finished")
	queue_free()
