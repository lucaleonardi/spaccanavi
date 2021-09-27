extends BaseBtn

func _on_button_up() -> void:
	Engine.time_scale = 1
	WaveManager.initialize()
	AudioManager.initialize()
	
	get_tree().paused = false
	get_tree().reload_current_scene()
