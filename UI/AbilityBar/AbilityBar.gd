extends Control

onready var ability_bar: NinePatchRect = $Fill
onready var tween: Tween = $Tween
onready var player_stats: Node = PlayerStats

var animated_ability := 0

func _ready() -> void:
	player_stats.connect("ability_changed", self, "update_ability_bar")
	ability_bar.max_value = player_stats.max_ability
	ability_bar.value = player_stats.max_ability
	
	animated_ability = ability_bar.value

func _process(delta: float) -> void:
	ability_bar.value = animated_ability
	ability_bar.tint_progress.h = bar_color
	
	print("bar color: ", bar_color)
	
func update_ability_bar(value: int) -> void:
	tween.interpolate_property(self, "animated_ability", animated_ability, value, 0.6)
	
	var _health_percentage = value * 100 / player_stats.max_ability
	var _hsv_percentage = _health_percentage * initial_bar_color / 100
	tween.interpolate_property(self, "bar_color", bar_color, _hsv_percentage, 0.6)
	
	if not tween.is_active():
		tween.start()
