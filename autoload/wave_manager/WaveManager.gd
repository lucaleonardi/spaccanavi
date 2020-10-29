extends Node

signal wave_fill_change
signal wave_completed

const _wave_multiplier := 1.5

var max_wave_bar = 500
var wave_bar := 0
var current_wave := 1


func increment_wave_bar(points: int) -> void:
	wave_bar += points
	
	if wave_bar >= max_wave_bar:
		next_wave()
	else:
		emit_signal("wave_fill_change", wave_bar)

func next_wave() -> void:	
	# 1. next wave
	current_wave += 1
	
	# 2. bar reset
	wave_bar = 0
	max_wave_bar *= _wave_multiplier
	emit_signal("wave_completed", max_wave_bar)
	
	# 3. end wave reward: player health refill
	PlayerStats.health = PlayerStats.max_health
