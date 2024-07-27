class_name Enemy
extends Node2D
@export_category("Life")
@export var health: int = 10
@export var enemy_damage: int = 1
@export var death_prefab: PackedScene
var DAMAGE_DIGIT: PackedScene
@onready var damage_marker = $DamageMarker

@export_category("Drops")
@export var drop_chance: float = 0.10
@export var drop_items: Array[PackedScene] = []
@export var drop_chances: Array[float] = []


func _ready():
	DAMAGE_DIGIT = preload("res://misc/damage_digit.tscn")

func damage(amount: int)->void:
	health -= amount
	print("I lost ", amount, " hit points! Now I have ", health, " hp.")
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	var damage_digit = DAMAGE_DIGIT.instantiate()
	damage_digit.global_position = damage_marker.global_position
	damage_digit.value = amount
	get_parent().add_child(damage_digit)
	if health <=0:
		die()
		
func die()->void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		death_object.scale = scale
		get_parent().add_child(death_object)
	if randf() <= drop_chance:
		drop_item()
	queue_free()

func drop_item() -> void:
	var drop_prefab = get_random_drop_item()
	var drop_object:Node2D = drop_prefab.instantiate()
	drop_object.position = position
	get_parent().add_child(drop_object)

func get_random_drop_item() -> PackedScene:
	if drop_items.size():
		return drop_items[0]
	var max_chance: float = 0.0
	for drop_chance in drop_chances:
		max_chance += drop_chance
	var rnd_value = randf() * max_chance
	var acc:float = 0.0
	for i in drop_items.size():
		var drop_item = drop_items[i]
		var drop_chance =  drop_chances[i] if i < drop_chances.size() else 1
		if rnd_value <= drop_chance+ acc:
			return drop_item
		acc += drop_chance
	return drop_items[0]
	
