extends Ability

onready var timer: Timer = $Timer

func _ready() -> void:
	timer.connect("timeout", self, "disable")
	activate()

func activate() -> void:
	timer.start(duration)
	get_parent().invincible = true
	get_parent().linear_damp = 2 * 1/Engine.time_scale

func disable() -> void:
	get_parent().invincible = false
	get_parent().linear_damp = 0.5 * 1/Engine.time_scale
	emit_signal("ability_finished")
	queue_free()
