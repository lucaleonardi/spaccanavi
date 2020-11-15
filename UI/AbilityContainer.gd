extends CenterContainer

onready var icon: TextureRect = $AbilityIcon

func _ready() -> void:
	PlayerStats.connect("signal_has_pickup", self, "set_ability")


func set_ability(has_pickup: bool) -> void:
	visible = has_pickup
	icon.texture = PlayerStats.ability_texture
