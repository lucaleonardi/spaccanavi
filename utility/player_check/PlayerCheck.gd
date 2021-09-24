extends Timer

export (float) var allowed_distance = 1500.0

onready var player = get_tree().root.get_node("World/Player/Default")
onready var parent = get_parent()

func _ready() -> void:
	connect("timeout", self, "_check_player_distance")

func _check_player_distance() -> void:
	if player.is_inside_tree(): # check if player is still alive
		if parent.global_position.distance_to(player.global_position) > allowed_distance:
			parent.queue_free()
