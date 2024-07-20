extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
var is_running: bool = false
@export var speed = 3
@onready var sprite_2d = $Sprite2D


func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	var target_velocity = input_vector * speed * 100.0
	velocity = lerp(velocity, target_velocity, 0.5)

	move_and_slide()
		
	var was_running = is_running
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
