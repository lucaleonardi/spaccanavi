extends Node2D

#onready var pointer: Sprite = $SpritePointer

	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	global_position = lerp(global_position, get_global_mouse_position(), 0.33)
