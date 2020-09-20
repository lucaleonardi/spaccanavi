extends Enemy

export (float) var speed = 500

onready var gun: Position2D = $Gun
onready var shooting_cooldown: Timer = $Gun/Cooldown
onready var player = get_tree().root.get_node("World/Player/Default")

func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		global_position += (player.global_position - global_position) / speed
		look_at(player.global_position)
	
	if shooting_cooldown.is_stopped() and get_tree().root.get_node("World/Player").has_node("Default"):
		gun.shoot(modulate, global_rotation, Vector2.ZERO)
		shooting_cooldown.start()
	
	
