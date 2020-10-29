extends RigidBody2D
class_name Player

const effect_path: String = Preload.EFFECT.DEATH
const DeathEffect := preload(effect_path)

export (int) var engine_thrust = 12000
export (int) var max_speed = 2400
export (float) var spin_thrust = .1

# proprieties of each spaceship
export (int) var health = 100

onready var hitbox: CollisionPolygon2D = $Hitbox
onready var raycast: RayCast2D = $ShootingDirection
onready var gun: Position2D = $ShootingDirection/Gun
onready var shooting_cooldown: Timer = $ShootingDirection/Gun/Cooldown

onready var hurt_sound: AudioStreamPlayer = $HurtSound
onready var blinkAnimationPlayer: AnimationPlayer = $BlinkAnimationPlayer

var input_vector := Vector2.ZERO
var thrust = Vector2()
var rotation_dir = 0
var speed := 0
var invincible := false

var max_actual_speed = max_speed
var actual_speed := Vector2.ZERO

var has_pickup := false
var ability_has_finished := true
var ability_type: PackedScene

signal hit


func _ready() -> void:
	PlayerStats.max_health = health
	PlayerStats.health = health
	PlayerStats.connect("no_health", self, "death")
	
	gun.bullet_group = "player"

func _process(delta):
	input_vector = get_input()

func _physics_process(delta):
	hitbox.rotation = raycast.rotation + PI/2	
	raycast.rotation = lerp_angle(raycast.rotation, get_angle_to(get_global_mouse_position()), spin_thrust)	
	
	set_applied_force(input_vector * engine_thrust)
	linear_velocity.x = clamp(linear_velocity.x, -max_actual_speed, max_actual_speed)
	linear_velocity.y = clamp(linear_velocity.y, -max_actual_speed, max_actual_speed)
	
	if Input.is_action_just_pressed("activate_pickup") and has_pickup and ability_has_finished:
		activate_pickup(ability_type)
	
	if Input.is_action_pressed("shoot") and shooting_cooldown.is_stopped():
		gun.shoot(modulate, raycast.rotation, linear_velocity)
		shooting_cooldown.start()

func get_input() -> Vector2:	
	return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()

func activate_pickup(Ability) -> void:
	has_pickup = false
	# NOTE: actually I think that a player can use multiple abilities at once
	ability_has_finished = false
	
	var ability = Ability.instance()
	add_child(ability)

	yield(get_tree().create_timer(5.0), "timeout")
	
	ability.disable()
	ability_has_finished = true

func death() -> void:
	queue_free()
	var death_effect: CPUParticles2D = DeathEffect.instance()
	death_effect.connect("effect_finished", death_effect, "queue_free")
	death_effect.global_position = global_position
	death_effect.emitting = true
	death_effect.set_modulate(modulate)
	
	death_effect.set_as_toplevel(true)
	get_parent().add_child(death_effect)

func is_picked(Ability) -> void:
	has_pickup = true
	ability_type = Ability

func _on_Player_body_entered(body: Node) -> void:
	if !invincible:
		hurt_sound.play()
		blinkAnimationPlayer.play("Start")
	
		if body is Bullet:
			emit_signal("hit", max(0.3, body.mass / 100))
			PlayerStats.health -= body.damage
		
		if body is Enemy:
			var _velocity = int(
					(abs(linear_velocity.x) + abs(linear_velocity.y)) / 2
				)
			var _player_mass = mass
			var _enemy_mass = body.mass
			var _collision_damage = _velocity * _enemy_mass / _player_mass / 200
	
			emit_signal("hit", max(0.3, _collision_damage / 20))
			PlayerStats.health -= _collision_damage
