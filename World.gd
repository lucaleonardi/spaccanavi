extends Node2D

func _ready() -> void:
	init()

func init() -> void:
	Engine.time_scale = 1
	AudioManager.initialize()
	AudioManager.play('main')
