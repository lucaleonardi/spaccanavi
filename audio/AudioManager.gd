extends Node

onready var menu: AudioStreamPlayer = $MenuTrack
onready var main: AudioStreamPlayer = $MainTrack
onready var tween: Tween = $Tween

func initialize() -> void:
	main.pitch_scale = 1
	tween.stop_all()

func play(track: String) -> void:
	match(track):
		'menu':
			menu.play()
		'main':
			main.play()


func stop() -> void:
	menu.stop()
	main.stop()

func filter_out() -> void:
	tween.start()
	tween.interpolate_property(main, "pitch_scale", null, 0.01, 10, tween.TRANS_QUINT, tween.EASE_OUT)
