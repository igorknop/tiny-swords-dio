class_name Enemy
extends Node2D

@export var health: int = 10
@export var enemy_damage: int = 1
@export var death_prefab: PackedScene

func damage(amount: int)->void:
	health -= amount
	print("I lost ", amount, " hit points! Now I have ", health, " hp.")
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	if health <=0:
		die()
		
func die()->void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		death_object.scale = scale
		get_parent().add_child(death_object)
		queue_free()
	
