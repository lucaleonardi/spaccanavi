extends RigidBody2D
class_name Player

export (int) var engine_thrust = 12000
export (int) var max_speed = 2400
export (float) var spin_thrust = .1

const effect_path: String = Preload.EFFECT.DEATH
const DeathEffect := preload(effect_path)

onready var hitbox: CollisionPolygon2D = $Hitbox
onready var raycast: RayCast2D = $ShootingDirection
onready var gun: Position2D = $ShootingDirection/Gun
onready var shooting_cooldown: Timer = $ShootingDirection/Gun/Cooldown
onready var stats: Node = $Stats

onready var _last_linear_velocity := linear_velocity

var thrust = Vector2()
var rotation_dir = 0
var input_vector := Vector2.ZERO
var speed := 0
var max_actual_speed = max_speed
var actual_speed := Vector2.ZERO

var boost := Vector2.ZERO

var boosting := false

func get_input() -> Vector2:	
	return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()

func boost_check() -> void:
	if Input.is_action_pressed("boost"):
		boost = Vector2(
			cos(get_angle_to(get_global_mouse_position())), 
			sin(get_angle_to(get_global_mouse_position()))
			) * engine_thrust * 4
		max_actual_speed = max_speed * 1.5
	else:
		boost = Vector2.ZERO
		max_actual_speed = max_speed

func _process(delta):
	input_vector = get_input()

func _physics_process(delta):
	hitbox.rotation = raycast.rotation + PI/2
	boost_check()
		
	raycast.rotation = lerp_angle(raycast.rotation, get_angle_to(get_global_mouse_position()), spin_thrust)	
	set_applied_force(input_vector * engine_thrust + boost)
	linear_velocity.x = clamp(linear_velocity.x, -max_actual_speed, max_actual_speed)
	linear_velocity.y = clamp(linear_velocity.y, -max_actual_speed, max_actual_speed)
	
	if Input.is_action_pressed("shoot") and !Input.is_action_pressed("boost") and shooting_cooldown.is_stopped():
		gun.shoot(modulate, raycast.rotation, linear_velocity)
		shooting_cooldown.start()
	
#	if _last_linear_velocity != linear_velocity:
#		_last_linear_velocity = linear_velocity

func _on_Player_body_entered(body: Node) -> void:
	if body is Bullet:
		stats.health -= body.damage
	
	if body is Enemy:
		var _velocity = int(
				(abs(linear_velocity.x) + abs(linear_velocity.y)) / 2
			)
		
		var _player_mass = mass
		var _enemy_mass = body.mass
		
		var _collision_damage = _velocity * _enemy_mass / _player_mass / 200
		
		stats.health -= _collision_damage
		
#		print("the linear velocity when the signal is emitted: ", linear_velocity)
#		print("the last linear velocity: ", _last_linear_velocity)
#		print("velocity: ", _velocity)
#		print("damage: ", _collision_damage)


func _on_Stats_no_health() -> void:
	queue_free()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.connect("effect_finished", death_effect, "queue_free")
	death_effect.global_position = global_position
	death_effect.emitting = true
	death_effect.set_modulate(modulate)
	
	death_effect.set_as_toplevel(true)
	get_parent().add_child(death_effect)
