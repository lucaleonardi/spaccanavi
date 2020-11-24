extends Ability

onready var timer: Timer = $Timer

var player = get_parent()

func _ready() -> void:
	timer.connect("timeout", self, "disable")
	activate()

func activate() -> void:
	timer.start(duration)
	player.invincible = true
	player.linear_damp = 2 * 1/Engine.time_scale

func disable() -> void:
	player.invincible = false
	player.linear_damp = 0.5 * 1/Engine.time_scale
	emit_signal("ability_finished")
	queue_free()
