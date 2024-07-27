extends Node
var time: float = 0.0

@export var mob_spawner: MobSpawner
@export var mobs_increase_per_minute: float = 30.0
@export_range(1.0, 120.0) var wave_duration: float = 20
@export var initial_mobs_per_minute: float = 60.0
@export var break_intensity: float = 0.5


func _process(delta:float)-> void:
	if GameManager.is_game_over: return
	time += delta
	var spawn_rate = initial_mobs_per_minute + mobs_increase_per_minute * time/60.0
	var sin_wave = sin(time*TAU/wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity, 1)
	spawn_rate += wave_factor
	
	mob_spawner.mobs_per_minute  = spawn_rate
