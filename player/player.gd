extends CharacterBody2D

@export var speed = 3
@export var sword_damage:int = 2

@export var health: int = 100
@export var death_prefab: PackedScene

var input_vector: Vector2 = Vector2(0,0)
var is_running: bool = false
var was_running: bool = false
var is_attacking: bool = false
var attack_cooldown: float = 0.0
var hitbox_cooldown: float = 0.0

@onready var sword_area_2d = $SwordArea2D
@onready var hitbox_area_2d = $HitBoxArea2D
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

func _process(delta):
	read_input()	
	if is_attacking:
		attack_cooldown-=delta
		if attack_cooldown<=0.0:
			is_attacking = false
			is_running = false
			animation_player.play("idle")
	update_hitbox_detection(delta)
		
func read_input():
	input_vector = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")	
	was_running = is_running
	is_running = not input_vector.is_zero_approx()
	if is_running != was_running:
		if is_running:
			animation_player.play("run")
		else:
			animation_player.play("idle")
	if input_vector.x > 0:
		sprite_2d.flip_h = false
	elif input_vector.x < 0:
		sprite_2d.flip_h = true
		
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	var target_velocity = input_vector * speed * 100.0
	if is_attacking:
		target_velocity*=0.25
	velocity = lerp(velocity, target_velocity, 0.5)
	GameManager.player_position = position
	move_and_slide()
		
	

func attack():
	if is_attacking:
		return
	attack_cooldown = 0.6
	animation_player.play("attack_side_1")
	is_attacking = true


func deal_damage_to_enemies() -> void:
	if health <=0: return
	var bodies = sword_area_2d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy:Enemy = body
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			if sprite_2d.flip_h:
				attack_direction = Vector2.LEFT
			else:
				attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			if dot_product>=0.4:
				print("Dot: ", dot_product)
				enemy.damage(sword_damage)

func update_hitbox_detection(delta: float) -> void:
	hitbox_cooldown -= delta
	if hitbox_cooldown > 0:
		return
	var bodies = hitbox_area_2d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy:Enemy = body
			var damage_amount = enemy.enemy_damage
			damage(damage_amount)
			
	


func damage(amount: int)->void:
	health -= amount
	print("Player lost ", amount, " hit points! Now I have ", health, " hp.")
	modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)
	if hitbox_cooldown <= 0.0:
		hitbox_cooldown = 0.5	
	if health <=0:
		die()
		
func die()->void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		death_object.scale = scale
		get_parent().add_child(death_object)
		print("Player died!")
		queue_free()
