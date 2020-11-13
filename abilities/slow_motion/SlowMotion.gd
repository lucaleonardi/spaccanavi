extends Ability

onready var player = get_parent()
onready var tween_slow: Tween = $SlowDown
onready var tween_speed: Tween = $SpeedUp
onready var _tween_duration = duration / 2

onready var timer: Timer = $Timer

const slomo_value = 4

var _player_shooting_cooldown
var _player_linear_damp


func _process(delta: float) -> void:
	AudioManager.main.pitch_scale = sqrt(Engine.time_scale)
	
func _physics_process(delta: float) -> void:
	player.shooting_cooldown.wait_time = _player_shooting_cooldown / (1 / Engine.time_scale)
	player.linear_damp = _player_linear_damp / (1 / Engine.time_scale)


func _ready() -> void:
	timer.start(duration)
	timer.connect("timeout", self, "disable")
	_player_shooting_cooldown = player.shooting_cooldown.wait_time
	_player_linear_damp = player.linear_damp
	
	tween_slow.start()
	tween_slow.interpolate_property(
		Engine, 
		"time_scale", 
		null, 
		Engine.time_scale / slomo_value, 
		_tween_duration, 
		tween_slow.TRANS_QUINT, 
		tween_slow.EASE_OUT)

func disable() -> void:
	tween_speed.start()
	tween_speed.interpolate_property(
		Engine, 
		"time_scale", 
		null, 
		Engine.time_scale * slomo_value, 
		_tween_duration / 4, 
		tween_speed.TRANS_QUINT, 
		tween_speed.EASE_IN)
	tween_speed.connect("tween_all_completed", self, "_completed")


func _completed() -> void:
	set_process(false)
	set_physics_process(false)
	
	tween_slow.stop_all()
	tween_speed.stop_all()
	
	AudioManager.main.pitch_scale = 1
	player.shooting_cooldown.wait_time = _player_shooting_cooldown
	player.linear_damp = _player_linear_damp
	Engine.time_scale = 1
	
	emit_signal("ability_finished")
	queue_free()
