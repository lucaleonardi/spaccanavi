extends Stats

export (int) var max_ability = 100 setget set_max_ability
var ability: int = max_ability setget set_ability

signal no_ability
signal ability_changed(value)
signal max_ability_changed(value)

func set_max_ability(value) -> void:
	max_ability = value
	self.ability = min(ability, max_ability)
	emit_signal("max_ability_changed", max_ability)
	
func set_ability(value) -> void:
	ability = value
	emit_signal("ability_changed", ability)
	if ability <= 0:
		emit_signal("no_ability")

func _ready() -> void:
	self.ability = max_ability
