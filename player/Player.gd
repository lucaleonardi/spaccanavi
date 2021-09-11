extends RigidBody2D
class_name Player

const effect_path: String = Preload.EFFECT.DEATH
const DeathEffect := preload(effect_path)

export (int) var engine_thrust = 12000
export (int) var max_speed = 2400
export (float) var spin_thrust = .1
export (float) var shooting_trigger_deadzone = .8

# proprieties of each spaceship
export (int) var health = 100

onready var hitbox: CollisionPolygon2D = $Hitbox
onready var raycast: RayCast2D = $ShootingDirection
onready var sprite: Sprite = $ShootingDirection/Sprite
onready var gun: Position2D = $ShootingDirection/Gun
onready var shooting_cooldown: Timer = $ShootingDirection/Gun/Cooldown

# mobile touchscreen controls
onready var joysticksContainer : MarginContainer = $TouchControls/MarginContainer
onready var joystickLeft : Joystick = $TouchControls/MarginContainer/JoystickLeft
onready var joystickRight : Joystick = $TouchControls/MarginContainer/AimAndAbility/JoystickRight

onready var hurt_sound: AudioStreamPlayer = $HurtSound
onready var blinkAnimationPlayer: AnimationPlayer = $BlinkAnimationPlayer

var input_vector := Vector2.ZERO
var thrust = Vector2()
var rotation_dir = 0
var speed := 0
var invincible := false

var max_actual_speed = max_speed
var actual_speed := Vector2.ZERO
var input_method := ""

var ability_has_finished := true
var ability_type: PackedScene

signal shake_camera


func _ready() -> void:
	if OS.has_touchscreen_ui_hint():
		input_method = "_touchscreen_controls"
		joysticksContainer.visible = true
	else:
		input_method = "_desktop_controls"
		joysticksContainer.visible = false
		
	PlayerStats.max_health = health
	PlayerStats.health = health
	PlayerStats.connect("no_health", self, "death")
	PlayerStats.has_pickup = false

	gun.bullet_group = "player"

func _process(delta):
	input_vector = get_input()

func _physics_process(delta):
	max_actual_speed = max_speed * 1/Engine.time_scale
	
	linear_velocity.x = clamp(linear_velocity.x, -max_actual_speed, max_actual_speed)
	linear_velocity.y = clamp(linear_velocity.y, -max_actual_speed, max_actual_speed)
	
	call(input_method)
	
	if Input.is_action_just_pressed("activate_pickup") and PlayerStats.has_pickup and ability_has_finished:
		activate_pickup(ability_type)


func _desktop_controls() -> void:
	hitbox.rotation = raycast.rotation + PI/2
	raycast.rotation = lerp_angle(raycast.rotation, get_angle_to(get_global_mouse_position()), spin_thrust * 1/Engine.time_scale)
	
	set_applied_force(input_vector * engine_thrust * 1/Engine.time_scale)
	
	if Input.is_action_pressed("shoot") and shooting_cooldown.is_stopped():
		gun.shoot(modulate, raycast.rotation, linear_velocity)
		shooting_cooldown.start()

func get_input() -> Vector2:	
	return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()


func _touchscreen_controls() -> void:
	hitbox.rotation = raycast.rotation + PI/2
	
	if joystickLeft:
		set_applied_force(joystickLeft.output * engine_thrust * 1/Engine.time_scale)
		if !joystickRight.is_working:
			raycast.rotation = lerp_angle(raycast.rotation, joystickLeft.output.angle(), spin_thrust * 1/Engine.time_scale)
	
	if joystickRight and joystickRight.is_working:
		raycast.rotation = lerp_angle(raycast.rotation, joystickRight.output.angle(), spin_thrust * 1/Engine.time_scale)

	if Vector2.ZERO.distance_to(joystickRight.output) >= shooting_trigger_deadzone and shooting_cooldown.is_stopped():
		gun.shoot(modulate, raycast.rotation, linear_velocity)
		shooting_cooldown.start()


func activate_pickup(Ability) -> void:	
	PlayerStats.has_pickup = false
	ability_has_finished = false

	var ability = Ability.instance()
	ability.connect("ability_finished", self, "disable_pickup")
	add_child(ability)

func disable_pickup() -> void:
	ability_has_finished = true

func is_picked(Ability) -> void:
	PlayerStats.has_pickup = true
	ability_type = Ability


func death() -> void:
	queue_free()
	AudioManager.filter_out()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.global_position = global_position
	death_effect.emitting = true
	death_effect.set_modulate(modulate)
	
	death_effect.set_as_toplevel(true)
	get_parent().add_child(death_effect)


func _on_Player_body_entered(body: Node) -> void:
	if !invincible:
		hurt_sound.play()
		blinkAnimationPlayer.play("Start")
	
		if body is Bullet:
			emit_signal("shake_camera", max(0.3, body.mass / 100))
			PlayerStats.health -= body.damage
		
		if body is Enemy:
			var _velocity = int(
					(abs(linear_velocity.x) + abs(linear_velocity.y)) / 2
				)
			var _player_mass = mass
			var _enemy_mass = body.mass
			var _collision_damage = _velocity * _enemy_mass / _player_mass / 200
	
			emit_signal("shake_camera", max(0.3, _collision_damage / 20))
			PlayerStats.health -= _collision_damage
