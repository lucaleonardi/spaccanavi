extends Node

# obiettivo: creare un sistema a ondate, per cui il giocatore inizia all'ondata 1
# e spawnano tot nemici. uccidendo i nemici, la barra dell'ondata si riempie e 
# quando arriva al massimo si passa all'ondata 2. ripetere a tempo indeterminato :)

# come ottenere questa cosa:
# 1. avere una struttura per cui il gioco sa a che ondata si trova
# 2. quando un nemico viene ucciso, il barra dell'ondata deve aumentare
# 3. quando arriva al massimo, passa all'ondata successiva
# 4. ripetere :)

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
