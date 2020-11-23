extends Enemy

onready var gun1: Position2D = $Gun1
onready var gun2: Position2D = $Gun2
onready var gun3: Position2D = $Gun3
onready var shooting_cooldown: Timer = $Gun1/Cooldown

var guns := []
var i := 0

func _ready() -> void:
	gun1.bullet_group = "enemy"
	gun2.bullet_group = "enemy"
	gun3.bullet_group = "enemy"
	
	guns = [
		{
			gun = gun1,
			rotate = -PI/4,
		},
		{
			gun = gun2,
			rotate = PI/2,
		},
		{
			gun = gun3,
			rotate = -PI+PI/4,
		},
	]

func _physics_process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		chase_player()

		if shooting_cooldown.is_stopped():
			if i > 2:
				i = 0
			
#			guns[0].gun.shoot(modulate, global_rotation + guns[0].rotate, linear_velocity)
#			guns[1].gun.shoot(modulate, global_rotation + guns[1].rotate, linear_velocity)
#			guns[2].gun.shoot(modulate, global_rotation + guns[2].rotate, linear_velocity)
			guns[i].gun.shoot(modulate, global_rotation + guns[i].rotate, linear_velocity)
			shooting_cooldown.start()
			
			i += 1
