extends Control

onready var health_bar: TextureProgress = $HealthBar
onready var tween: Tween = $Tween
onready var player_stats: Node = PlayerStats

var animated_health := 0

var initial_bar_color := 0.32 # Green in HSV
var bar_color := initial_bar_color

func _ready() -> void:
	player_stats.connect("health_changed", self, "update_health_bar")
	health_bar.max_value = player_stats.max_health
	health_bar.value = player_stats.max_health
	
	animated_health = health_bar.value

func _process(delta: float) -> void:
	health_bar.value = animated_health
	health_bar.tint_progress.h = bar_color
	
func update_health_bar(value: int) -> void:
	tween.interpolate_property(self, "animated_health", animated_health, value, 0.6)
	
	var _health_percentage = value * 100 / player_stats.max_health
	var _hsv_percentage = _health_percentage * initial_bar_color / 100
	tween.interpolate_property(self, "bar_color", bar_color, _hsv_percentage, 0.6)
	
	if not tween.is_active():
		tween.start()
