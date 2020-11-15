extends Stats

var has_pickup: bool = false setget set_has_pickup, get_has_pickup
var ability_duration: float = 0.0 setget set_ability_duration
var ability_texture: Texture

signal signal_has_pickup

func set_has_pickup(value: bool) -> void:
	has_pickup = value
	emit_signal("signal_has_pickup", has_pickup)

func get_has_pickup() -> bool:
	return has_pickup

func set_ability_duration(value: float) -> void:
	ability_duration = value
