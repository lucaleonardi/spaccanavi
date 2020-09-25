extends RigidBody2D
class_name Pickup

export (PackedScene) var PickupItem
export (Texture) var texture

signal picked_up

func _ready() -> void:
	$Sprite.texture = texture


func _on_PickupArea_body_entered(body: Node) -> void:
	if body is Player and !body.has_pickup:
		connect("picked_up", body, "is_picked", [PickupItem])
		emit_signal("picked_up")
		queue_free()
