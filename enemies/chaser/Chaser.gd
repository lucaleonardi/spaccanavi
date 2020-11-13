extends Enemy

	
func _physics_process(delta):
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
#		look_at(player.global_position)
		rotation = lerp_angle(rotation, get_angle_to(player.global_position) + rotation, Engine.time_scale * Engine.time_scale)
		linear_damp = 2 / Engine.time_scale


func _on_Chaser_body_entered(body: Node) -> void:
	if body is Bullet:
		stats.health -= body.damage
		
		if body.is_in_group("enemy"):
			_is_hit_by_player = false
		elif body.is_in_group("player"):
			_is_hit_by_player = true
	
	if body is Player:
		stats.health = 0
