extends RigidBody2D
class_name Bullet

export (float) var damage = 1.0

signal hit


func destroy() -> void:
	queue_free()

func _on_timeout() -> void:
	destroy()

func _on_hit(body: Node) -> void:
	emit_signal("hit", body.modulate, global_position)
	destroy()
