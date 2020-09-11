extends Enemy

export (float) var speed = 50

onready var player = get_tree().root.get_node("World/Player/Default")

func _physics_process(delta):
	position += (player.position - position) / speed
	look_at(player.position)
