extends CPUParticles2D

onready var effect_duration: Timer = $Lifetime

signal effect_finished

func _ready() -> void:
	effect_duration.set_wait_time(lifetime)
	effect_duration.start()

func _on_effect_finished() -> void:
	emit_signal("effect_finished")
