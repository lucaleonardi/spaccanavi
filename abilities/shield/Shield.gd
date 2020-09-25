extends Ability

func _ready() -> void:
	get_parent().invincible = true
	get_parent().linear_damp = 2

func disable() -> void:
	get_parent().invincible = false
	get_parent().linear_damp = 0.5
	queue_free()
