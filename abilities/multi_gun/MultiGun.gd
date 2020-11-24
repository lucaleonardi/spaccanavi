extends Node2D

onready var timer: Timer = $Timer
onready var player = get_parent()

export (float) var duration = 10.0

onready var gun2: Position2D = $Gun2
#onready var gun3: Position2D = $Gun3
onready var gun4: Position2D = $Gun4
#onready var gun5: Position2D = $Gun5
onready var gun7: Position2D = $Gun7
#onready var gun8: Position2D = $Gun8
onready var gun9: Position2D = $Gun9
#onready var gun10: Position2D = $Gun10
onready var shooting_cooldown: Timer = $Gun2/Cooldown

signal ability_finished

func _ready() -> void:
	gun2.bullet_group = "player"
	gun4.bullet_group = "player"
	gun7.bullet_group = "player"
	gun9.bullet_group = "player"
	
	timer.connect("timeout", self, "disable")
	activate()
	

func activate() -> void:
	timer.start(duration)


func _physics_process(delta: float) -> void:
	rotation = player.raycast.rotation
	
	if Input.is_action_pressed("shoot") and shooting_cooldown.is_stopped():
		gun2.shoot(player.modulate, rotation + deg2rad(7.0), player.linear_velocity) #positivo
		gun4.shoot(player.modulate, rotation + deg2rad(21.0), player.linear_velocity) #positivo
		gun7.shoot(player.modulate, rotation - deg2rad(7.0), player.linear_velocity) #negativo
		gun9.shoot(player.modulate, rotation - deg2rad(21.0), player.linear_velocity) #negativo
		shooting_cooldown.start()		
		
#		gun2.shoot(player.modulate, rotation, player.linear_velocity)
#		gun3.shoot(player.modulate, rotation, player.linear_velocity)
#		gun5.shoot(player.modulate, rotation, player.linear_velocity)
#		gun7.shoot(player.modulate, rotation, player.linear_velocity)
#		gun8.shoot(player.modulate, rotation, player.linear_velocity)
#		gun10.shoot(player.modulate, rotation, player.linear_velocity)


func disable() -> void:	
	set_physics_process(false)	
	emit_signal("ability_finished")
	queue_free()
