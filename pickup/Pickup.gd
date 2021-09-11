extends RigidBody2D
class_name Pickup

export (PackedScene) var PickupItem
export (Texture) var texture
export (int) var attraction = 5

var player: RigidBody2D

signal picked_up

func _ready() -> void:
	set_physics_process(false)
	$Type.texture = texture
	$RotatingOutline.play('start')
		
func _on_PickupArea_body_entered(body: Node) -> void:
	if body is Player and !PlayerStats.has_pickup:
		PlayerStats.ability_texture = texture
		connect("picked_up", body, "is_picked", [PickupItem])
		emit_signal("picked_up")
		queue_free()


func _physics_process(delta: float) -> void:
	set_applied_force(
		global_position.direction_to(player.global_position) 
		* attraction
		)

func _on_MagnetArea_body_entered(body: Node) -> void:
	if body is Player and !PlayerStats.has_pickup:
		player = body
		set_physics_process(true)

func _on_MagnetArea_body_exited(body: Node) -> void:
	if body is Player:
		set_physics_process(false)
		set_applied_force(Vector2.ZERO)
