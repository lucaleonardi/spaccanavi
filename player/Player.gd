extends RigidBody2D

export (int) var engine_thrust = 1200
export (int) var max_speed = 2400
export (float) var spin_thrust = .08

onready var hitbox: CollisionPolygon2D = $Hitbox
onready var raycast: RayCast2D = $ShootingDirection
onready var gun: Position2D = $ShootingDirection/Gun
onready var shooting_cooldown: Timer = $ShootingDirection/Gun/Cooldown

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
#		actual_speed += raycast.get_cast_to() * engine_thrust
#		add_force(Vector2.ZERO, Vector2.RIGHT)
#	else:
#		actual_speed = input_vector * engine_thrust
#		add_force(Vector2.ZERO, Vector2.LEFT)
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
		gun.shoot(raycast.rotation, linear_velocity)
		shooting_cooldown.start()
