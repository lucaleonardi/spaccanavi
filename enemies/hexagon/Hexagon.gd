extends Enemy

onready var gun1: Position2D = $GunsPositioning/Gun1
onready var gun2: Position2D = $GunsPositioning/Gun2
onready var shooting_cooldown: Timer = $GunsPositioning/Gun1/Cooldown

func _physics_process(delta: float) -> void:
	if shooting_cooldown.is_stopped():
		gun1.shoot(global_rotation - PI/2, Vector2.ZERO)
		gun2.shoot(global_rotation + PI/2, Vector2.ZERO)
		shooting_cooldown.start()
