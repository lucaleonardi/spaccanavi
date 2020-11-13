extends Camera2D

onready var topLeft: Position2D = $Limits/TopLeft
onready var bottomRight: Position2D = $Limits/BottomRight
onready var noise = OpenSimplexNoise.new()
var noise_y := 0

export (float) var decay = 0.8
export (Vector2) var max_offset = Vector2(100, 75)
export (float) var max_roll = 0.1
export (bool) var enable_limits = false

var trauma := 0.0
var trauma_power := 2

var player
var mouse_position

var distance
var pointer_drag := Vector2(170, 96)

func _ready() -> void:
	if enable_limits:
		limit_top = topLeft.position.y
		limit_left = topLeft.position.x
		limit_bottom = bottomRight.position.y
		limit_right = bottomRight.position.x
	
	player = get_tree().root.get_node("World/Player/Default")
	player.connect("shake_camera", self, "add_trauma")
	
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta: float) -> void:
	if get_tree().root.get_node("World/Player").has_node("Default"):
		distance = get_global_mouse_position() - player.global_position
		offset.x = lerp(offset.x, clamp(distance.x, -pointer_drag.x, pointer_drag.x) / 2, 0.1)
		offset.y = lerp(offset.y, clamp(distance.y, -pointer_drag.y, pointer_drag.y) / 2, 0.1)
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func add_trauma(amount: float) -> void:
	trauma = min(trauma + amount, 1.0)

func shake() -> void:
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x += max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y += max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
