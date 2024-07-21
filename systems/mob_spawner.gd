extends Node2D

@onready var path_follow_2d = %PathFollow2D
@export var creatures: Array[PackedScene]
@export var spawn_freq: float = 1.0;

var cooldown:float = 0.0;

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.position

func _process(delta):
	cooldown -= delta
	if cooldown <= 0.0:
		cooldown = 60.0 / spawn_freq;
		var new_mob = creatures.pick_random().instantiate()
		new_mob.position = get_point()
		get_parent().add_child(new_mob)
		spawn_freq+=1
		
