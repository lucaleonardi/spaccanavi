extends VBoxContainer

onready var label: Label = $Label
onready var wave_bar: TextureProgress = $WaveBar
onready var tween: Tween = $Tween

var animated_wave := 0

func _ready() -> void:
	WaveManager.connect("wave_fill_change", self, "update_wave_bar")
	WaveManager.connect("wave_completed", self, "on_complete_fill")
	wave_bar.max_value = WaveManager.max_wave_bar
	
	label.text = str("WAVE ", WaveManager.current_wave)

func _process(delta: float) -> void:
	wave_bar.value = animated_wave

func update_wave_bar(wave_fill: int) -> void:
	tween.interpolate_property(self, "animated_wave", animated_wave, wave_fill, 0.25)
	
	if not tween.is_active():
		tween.start()

func on_complete_fill(new_max_value: int) -> void:
	update_wave_bar(0)
	wave_bar.max_value = new_max_value
	label.text = str("WAVE ", WaveManager.current_wave)
