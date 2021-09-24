extends TextureButton
class_name BaseBtn

func _on_button_up() -> void:
	pass

func _on_hover() -> void:
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("hover")
