extends Ability

func _ready() -> void:
	PlayerStats.health = PlayerStats.max_health
	disable()
