extends HBoxContainer

onready var health_bar: TextureProgress = $VBoxContainer/HealthBarProgress
onready var ability_icon: TextureRect = $MarginContainer/CenterContainer/AbilityIcon
onready var tween: Tween = $Tween

var animated_health := 0

var initial_bar_color := 0.264 # Green in HSV 
var bar_color := initial_bar_color

func _ready() -> void:
	PlayerStats.connect("health_changed", self, "update_health_bar")
	PlayerStats.connect("signal_has_pickup", self, "set_ability")
	health_bar.max_value = PlayerStats.max_health
	animated_health = health_bar.max_value

func _process(delta: float) -> void:
	health_bar.value = animated_health
	health_bar.tint_progress.h = bar_color
	
func update_health_bar(value: int) -> void:
	tween.interpolate_property(self, "animated_health", animated_health, value, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	var _health_percentage = value * 100 / PlayerStats.max_health
	var _hsv_percentage = _health_percentage * initial_bar_color / 100
	tween.interpolate_property(self, "bar_color", bar_color, _hsv_percentage, 0.6)
	
	if not tween.is_active():
		tween.start()


func set_ability(has_pickup: bool) -> void:
	$MarginContainer/CenterContainer/AbilityBg.visible = has_pickup
	ability_icon.visible = has_pickup
	ability_icon.texture = PlayerStats.ability_texture
