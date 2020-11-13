extends Ability

onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start(duration)
	timer.connect("timeout", self, "disable")
	get_parent().invincible = true
	get_parent().linear_damp = 2

func disable() -> void:
	get_parent().invincible = false
	get_parent().linear_damp = 0.5
	emit_signal("ability_finished")
	queue_free()
