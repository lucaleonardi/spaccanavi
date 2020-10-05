extends Enemy

onready var gun1: Position2D = $GunsPositioning/Gun1
onready var gun2: Position2D = $GunsPositioning/Gun2
onready var shooting_cooldown: Timer = $GunsPositioning/Gun1/Cooldown

func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()
	
	if shooting_cooldown.is_stopped() and get_tree().root.get_node("World/Player").has_node("Default"):
		gun1.shoot(modulate, global_rotation - PI/2, linear_velocity)
		gun2.shoot(modulate, global_rotation + PI/2, linear_velocity)
		shooting_cooldown.start()
