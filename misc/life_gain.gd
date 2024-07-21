extends AnimatedSprite2D

@export var life_gain = 20


func _ready():
	$Area2D.body_entered.connect(on_body_entered)
	
	
func on_body_entered(body: Node2D)->void:
	print(body)
	if body.is_in_group("player"):
		var player: Player = body
		player.heal(life_gain)
		play("despawn")
		queue_free()
