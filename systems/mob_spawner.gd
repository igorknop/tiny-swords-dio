class_name MobSpawner
extends Node2D

@onready var path_follow_2d = %PathFollow2D
@export var creatures: Array[PackedScene]
var mobs_per_minute = 60.0

var cooldown:float = 0.0
var time: float

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.position

func _process(delta):
	if GameManager.is_game_over: return
	cooldown -= delta
	if cooldown <= 0.0:
		cooldown = mobs_per_minute / 60.0;
		var spoint = get_point()
		var world_state = get_world_2d().direct_space_state
		var parameters = PhysicsPointQueryParameters2D.new()
		parameters.position = spoint
		parameters.collision_mask = 0b1000
		var result:Array = world_state.intersect_point(parameters, 1)
		if not result.is_empty(): return
		var new_mob = creatures.pick_random().instantiate()
		new_mob.position = get_point()
		get_parent().add_child(new_mob)
		
		
