extends Node
class_name Ability

export (float) var duration = 5.0

signal ability_finished


func disable() -> void:
	emit_signal("ability_finished")
	queue_free()
