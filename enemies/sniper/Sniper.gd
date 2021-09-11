extends Enemy

const hit_effect_path: String = Preload.EFFECT.HIT
var HitEffect = preload(hit_effect_path)

export (float) var damage = 10

onready var shot_fx: AudioStreamPlayer = $Shot
onready var tween: Tween = $Tween

onready var raycast: RayCast2D = $RayCast2D
onready var beam: Sprite = $Beam
onready var end: Position2D = $End

var collider_body
var original_end_position: Vector2
var color_out_of_sight := Color(1.0, 1.0, 0.0, 0.5) # a = 0.625
#var color_on_sight := Color(1.0, 0.0, 0.0, 1) #(893, 0, 0, 0.625)
var shooting_cooldown := 0.0


func _ready() -> void:
	original_end_position = end.position
	
func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
		rotation = lerp_angle(rotation, get_angle_to(player.global_position) + rotation, Engine.time_scale/8)
		beam.visible = true
		beam.region_rect.end.x = end.position.length()
		
		if raycast.is_colliding():
			end.global_position = raycast.get_collision_point()
			
			collider_body = raycast.get_collider()
			if collider_body is Player:
				if shooting_cooldown < 1.0:
					shooting_cooldown += 0.0125

				beam.set_modulate(Color(1.0, 1.0 - shooting_cooldown, 0.0, shooting_cooldown))
				
				if shooting_cooldown >= 1.0:
					create_hit_effect(player.modulate, raycast.get_collision_point(), global_position.direction_to(player.global_position))
					shot_fx.play()
					shooting_cooldown = 0

					if !collider_body.invincible:
						PlayerStats.health -= damage
						player.blinkAnimationPlayer.play("Start")
			else:
				shooting_cooldown = 0.0
				beam.set_modulate(color_out_of_sight)
		else:
			shooting_cooldown = 0.0
			beam.set_modulate(color_out_of_sight)
			end.position = original_end_position
		
	else:
		beam.visible = false


func _on_player_out_of_sight() -> void:
	beam.visible = false


func create_hit_effect(enemy_color: Color, hit_global_position: Vector2, hit_direction: Vector2) -> void:
	var hit: CPUParticles2D = HitEffect.instance()
	hit.global_position = hit_global_position
	hit.set_direction(-hit_direction)
	hit.set_emitting(true)
	hit.set_modulate(enemy_color)
	
	hit.set_as_toplevel(true)
	add_child(hit)
