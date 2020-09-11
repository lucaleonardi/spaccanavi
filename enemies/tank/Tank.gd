extends Enemy

export (float) var speed = 500

onready var gun: Position2D = $Gun
onready var shooting_cooldown: Timer = $Gun/Cooldown
onready var player = get_tree().root.get_node("World/Player/Default")

func _physics_process(delta):
	position += (player.position - position) / speed
	look_at(player.position)
	
	if shooting_cooldown.is_stopped():
		gun.shoot(global_rotation, Vector2.ZERO)
		shooting_cooldown.start()
	
	
