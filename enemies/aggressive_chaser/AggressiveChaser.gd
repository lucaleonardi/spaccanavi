extends Enemy

onready var gun: Position2D = $Gun
onready var shooting_cooldown: Timer = $Gun/Cooldown
onready var spread_cooldown: Timer = $SpreadCooldown

var spread_counter := 0
	
	
func _ready() -> void:
	gun.bullet_group = "enemy"
	
func _physics_process(delta):
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
		rotation = lerp_angle(rotation, get_angle_to(player.global_position) + rotation, Engine.time_scale * Engine.time_scale)
		linear_damp = 2 / Engine.time_scale
	
	if spread_cooldown.is_stopped():
		if shooting_cooldown.is_stopped() and get_tree().root.get_node("World/Player").has_node("Default"):
			gun.shoot(modulate, global_rotation, linear_velocity)
			shooting_cooldown.start()
			spread_counter += 1
	
	if spread_counter > 2:
		spread_cooldown.start()
		spread_counter = 0


func _on_Enemy_body_entered(body: Node) -> void:
	if body is Bullet:
		if body.is_in_group("enemy"):
			_is_hit_by_player = false
		elif body.is_in_group("player"):
			_is_hit_by_player = true
		
		stats.health -= body.damage
			
	if body is Player:
		var _velocity = int(
			(abs(linear_velocity.x) + abs(linear_velocity.y)) / 2
		)
		var _mass = mass
		var _body_mass = body.mass
		var _collision_damage = _velocity * _body_mass / _mass / 200
		
		stats.health -= _collision_damage
