extends Node2D

const smoothness := 0.5 # default 0.33
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if OS.has_touchscreen_ui_hint():
		set_process(false)
		visible = false

func _process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position(), smoothness)
