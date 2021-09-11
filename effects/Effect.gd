extends CPUParticles2D

onready var duration: Timer = $Duration

func _ready() -> void:
	duration.connect("timeout", self, "queue_free")
	duration.start(lifetime)
