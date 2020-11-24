extends Node2D

const MAX_LENGTH = 2000

export (float) var duration = 5.0
export (float) var damage = 100

signal ability_finished

onready var timer: Timer = $Timer
onready var player = get_parent()

onready var beam: Sprite = $Beam
onready var end: Position2D = $End
onready var rayCast2D: RayCast2D = $RayCast2D

var collider_body

func _ready() -> void:
	rotation = player.raycast.rotation
#	end.global_position = rayCast2D.cast_to
#	beam.region_rect.end.x = end.global_position.length()
	
	player.shooting_cooldown.paused = true
	player.linear_damp = 2
	
	timer.connect("timeout", self, "disable")
	activate()

func activate() -> void:
	timer.start(duration)
	
	
func disable() -> void:
	player.shooting_cooldown.paused = false
	player.shooting_cooldown.stop()
	
	set_physics_process(false)
	player.linear_damp = 0.5
		
	emit_signal("ability_finished")
	queue_free()

func _physics_process(delta: float) -> void:
	player.emit_signal("shake_camera", 0.1)
	rotation = player.raycast.rotation

	if rayCast2D.is_colliding():
		end.global_position = rayCast2D.get_collision_point()
		
		collider_body = rayCast2D.get_collider()
		if collider_body is Enemy:
			collider_body._is_hit_by_player = true
			collider_body.stats.health -= damage
		else:
			collider_body.queue_free()
	else:
		end.position = rayCast2D.cast_to
	
#	beam.region_rect.end.x = end.position.length()
