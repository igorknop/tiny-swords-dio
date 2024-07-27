extends Node
var time: float = 0.0

@export var mob_spawner: MobSpawner
@export var mobs_increase_per_minute: float = 30.0
@export var wave_duration: float = 20

func _process(delta:float)-> void:
	time += delta
