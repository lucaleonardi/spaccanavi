extends Node2D

export var speed = 2

func _ready() -> void:
	AudioManager.play('menu')

func _physics_process(delta: float) -> void:
	global_position += Vector2(5, 0)
	global_position += global_position.direction_to(get_global_mouse_position()) * speed

