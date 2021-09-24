extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var pause_title: Label = $PauseOverlay/Title
onready var continue_btn: CenterContainer = $PauseOverlay/CenterContainer/Options/CenterContainer #/ContinueBtn
onready var retry_btn: CenterContainer = $PauseOverlay/CenterContainer/Options/CenterContainer2 #/RetryBtn
onready var restart_btn: CenterContainer = $PauseOverlay/CenterContainer/Options/CenterContainer3 #/RestartBtn

var paused: = false setget set_paused

func _ready() -> void:
	PlayerStats.connect("no_health", self, "_on_player_death")
#
func _on_player_death() -> void:
	pause_title.text = "You died"
	yield(get_tree().create_timer(1.5), "timeout")
	pause_overlay.visible = true
	continue_btn.visible = false
	restart_btn.visible = false
	retry_btn.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value


func _on_Continue_button_up() -> void:
	self.paused = not paused
