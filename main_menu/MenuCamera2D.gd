extends Camera2D

var distance
var pointer_drag := Vector2(85, 48)

#func _process(delta: float) -> void:
#	distance = get_global_mouse_position() - global_position
#	offset.x = lerp(offset.x, clamp(distance.x, -pointer_drag.x, pointer_drag.x) / 2, 0.1)
#	offset.y = lerp(offset.y, clamp(distance.y, -pointer_drag.y, pointer_drag.y) / 2, 0.1)
