extends Enemy

onready var gun: Position2D = $Gun
onready var shooting_cooldown: Timer = $Gun/Cooldown

onready var hitbox: CollisionShape2D = $Hitbox
onready var raycast: RayCast2D = $RayCast2D


func _ready() -> void:
	gun.bullet_group = "enemy"
	
func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
		rotation = lerp_angle(rotation, get_angle_to(player.global_position) + rotation, pow(Engine.time_scale, 3))

		if raycast.is_colliding():
			if raycast.get_collider() is Player:
				shooting()
	

func shooting() -> void:
	if shooting_cooldown.is_stopped() and get_tree().root.get_node("World/Player").has_node("Default"):
		gun.shoot(modulate, global_rotation, linear_velocity)
		shooting_cooldown.start()

