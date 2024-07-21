extends CharacterBody2D

@export var speed = 3
@export var sword_damage:int = 2

var input_vector: Vector2 = Vector2(0,0)
var is_running: bool = false
var was_running: bool = false
var is_attacking: bool = false
var attack_cooldown: float = 0.0

@onready var sword_area_2d = $SwordArea2D
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

