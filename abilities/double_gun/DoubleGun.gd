extends Ability

onready var shooting_cooldown: Timer = $ShootingCooldown

#func _ready() -> void:
#	var Gun = get_parent().gun
#	var gun = Gun.instance()
#	gun.position = Gun.position

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and shooting_cooldown.is_stopped():
		get_parent().gun.shoot(get_parent().modulate, get_parent().raycast.rotation + PI, get_parent().linear_velocity)
		shooting_cooldown.start()


func disable() -> void:
	queue_free()
