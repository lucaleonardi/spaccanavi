extends RigidBody2D
class_name Bullet

export (float) var damage = 1.0

signal hit


func destroy() -> void:
	queue_free()

func _on_timeout() -> void:
	destroy()

func _on_hit(body: Node) -> void:
	var color = body.modulate
	emit_signal("hit", color, global_position)
	destroy()
