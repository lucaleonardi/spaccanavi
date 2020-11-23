extends Enemy

onready var gun1: Position2D = $Gun1
onready var gun2: Position2D = $Gun2
onready var gun3: Position2D = $Gun3
onready var gun4: Position2D = $Gun4
onready var shooting_cooldown: Timer = $Gun1/Cooldown
onready var spread_cooldown: Timer = $SpreadCooldown

var spread_counter := 0

func _ready() -> void:
	gun1.bullet_group = "enemy"
	gun2.bullet_group = "enemy"
	gun3.bullet_group = "enemy"
	gun4.bullet_group = "enemy"

func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
		linear_damp = 4 / Engine.time_scale
	
	if spread_cooldown.is_stopped():
		if shooting_cooldown.is_stopped() and get_tree().root.get_node("World/Player").has_node("Default"):
			gun1.shoot(modulate, global_rotation - PI/2, linear_velocity)
			gun2.shoot(modulate, global_rotation + PI/2, linear_velocity)
			gun3.shoot(modulate, global_rotation + PI, linear_velocity)
			gun4.shoot(modulate, global_rotation, linear_velocity)
			shooting_cooldown.start()
			spread_counter += 1
	
	if spread_counter > 2:
		spread_cooldown.start()
		spread_counter = 0
