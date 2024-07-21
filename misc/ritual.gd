extends Node2D

@export var ritual_damage: int = 1
@onready var area_2d = $Area2D

func deal_damage():
	var bodies = area_2d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			enemy.damage(ritual_damage)
